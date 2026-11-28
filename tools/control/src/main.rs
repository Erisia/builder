//! Server control tool.
//!
//! Talks to the running Minecraft server over RCON (vanilla, works on every
//! Minecraft version) to read the player count and to send commands. The
//! RCON port and password are read from ./server.properties, which start.py
//! rewrites with a fresh random password on every launch.
//!
//! RCON is the only channel: without it, commands fail, and the player count
//! is assumed to be non-zero so restarts still wait out their grace period.
//! Run it from the world directory (control.sh does); it works on that server.

use anyhow::{bail, Context, Result};
use std::convert::TryInto;
use std::io::{Read, Write};
use std::net::{SocketAddr, TcpStream};
use std::process;
use std::thread::sleep;
use std::time::{Duration, Instant};
use structopt::StructOpt;

#[derive(Debug, StructOpt)]
#[structopt(version = "0.2", author = "Baughn", name = "control")]
struct Opts {
    #[structopt(subcommand)]
    cmd: Command,
}

#[derive(Debug, StructOpt)]
enum Command {
    /// Warn players, wait for the server to empty (or the grace period to run out), then stop it.
    Stop {
        #[structopt(short, default_value = "180")]
        time: u64,

        #[structopt(name = "lazy", help = "Only restart if server has been up this many hours", long)]
        lazy: Option<u64>,
    },
    /// Verify the server is running and RCON is reachable.
    Check {},
    /// Print the number of players currently online.
    Players {},
    /// Print the number of online players who are not AFK. A player is AFK when their view
    /// direction has not changed for --afk-minutes. Call it regularly (start.py does, every
    /// 45 s): it remembers each player's last view direction in player-activity.tsv, so a
    /// player is only judged AFK after being watched that long.
    ActivePlayers {
        #[structopt(long, default_value = "10")]
        afk_minutes: u64,
    },
    /// Restart the server the next time it is empty (start.py checks every 45 s).
    /// Any restart clears the request.
    RestartWhenEmpty {
        /// Withdraw a pending request instead.
        #[structopt(long)]
        cancel: bool,
        /// Only report whether a request is pending.
        #[structopt(long)]
        status: bool,
    },
    /// Send a chat message to everyone on the server.
    Say {
        #[structopt(name = "message", required = true)]
        message: Vec<String>,
    },
}

const SERVER_PROPERTIES: &str = "server.properties";
/// Flag file start.py polls; see RestartWhenEmpty.
const RESTART_WHEN_EMPTY_FLAG: &str = "restart-when-empty";
/// active-players' memory: name, last seen view direction, unix time it last changed.
/// start.py deletes it at each start (a player rejoins with their saved direction).
const PLAYER_ACTIVITY: &str = "player-activity.tsv";

/// Online player names from `list` output (the text after the colon).
fn parse_player_names(list_output: &str) -> Vec<String> {
    match list_output.split_once(':') {
        Some((_, names)) => names
            .split(|c| c == ',' || c == '\n')
            .map(|n| n.trim().to_string())
            .filter(|n| !n.is_empty())
            .collect(),
        None => Vec::new(),
    }
}

/// Updates the activity memory with this poll's view directions and counts the active players.
/// `rotations` holds one entry per online player; None (unreadable) counts as active.
/// Returns the active count and the new memory (online players only, so a relog starts fresh).
fn judge_activity(
    old: &str,
    rotations: &[(String, Option<String>)],
    now: u64,
    afk_secs: u64,
) -> (u64, String) {
    let mut memory = std::collections::HashMap::new();
    for line in old.lines() {
        let f: Vec<&str> = line.split('\t').collect();
        if f.len() == 3 {
            if let Ok(t) = f[2].parse::<u64>() {
                memory.insert(f[0].to_string(), (f[1].to_string(), t));
            }
        }
    }
    let mut active = 0;
    let mut out = String::new();
    for (name, rotation) in rotations {
        let rotation = match rotation {
            Some(r) => r.replace('\t', " ").replace('\n', " "),
            None => {
                active += 1;
                continue;
            }
        };
        let changed = match memory.get(name) {
            Some((r, t)) if *r == rotation => *t,
            _ => now,
        };
        if now.saturating_sub(changed) < afk_secs {
            active += 1;
        }
        out.push_str(&format!("{}\t{}\t{}\n", name, rotation, changed));
    }
    (active, out)
}

fn restart_when_empty(cancel: bool, status: bool) -> Result<()> {
    let flag = std::path::Path::new(RESTART_WHEN_EMPTY_FLAG);
    if status {
        println!("{}", if flag.exists() { "restart-when-empty: pending" } else { "restart-when-empty: none" });
    } else if cancel {
        match std::fs::remove_file(flag) {
            Ok(()) => println!("restart-when-empty: cancelled"),
            Err(e) if e.kind() == std::io::ErrorKind::NotFound => println!("restart-when-empty: none pending"),
            Err(e) => return Err(e).context("removing restart-when-empty"),
        }
    } else {
        std::fs::write(flag, b"").context("writing restart-when-empty")?;
        println!("restart-when-empty: requested; the server restarts once it has been empty (AFK players do not count) for ~45 s");
    }
    Ok(())
}

/// `stop --lazy` exits with EX_TEMPFAIL when the server is too young to restart, so callers can tell.
const EXIT_LAZY_SKIP: i32 = 75;

const RCON_TYPE_RESPONSE: i32 = 0;
const RCON_TYPE_COMMAND: i32 = 2;
const RCON_TYPE_LOGIN: i32 = 3;
const RCON_MAX_PACKET: usize = 4096 + 10;

/// A minimal RCON client. One TCP connection per command; the server is local
/// and we only send a handful of commands per minute.
struct Rcon {
    port: u16,
    password: String,
}

impl Rcon {
    /// Reads enable-rcon, rcon.port and rcon.password from server.properties.
    fn from_properties(path: &str) -> Result<Rcon> {
        let text = std::fs::read_to_string(path).with_context(|| format!("reading {}", path))?;
        let mut enabled = false;
        let mut port: u16 = 25575;
        let mut password = String::new();
        for line in text.lines() {
            let line = line.trim();
            if line.starts_with('#') {
                continue;
            }
            let mut kv = line.splitn(2, '=');
            let key = kv.next().unwrap_or("").trim();
            let value = kv.next().unwrap_or("").trim();
            match key {
                "enable-rcon" => enabled = value == "true",
                "rcon.port" => port = value.parse().with_context(|| format!("parsing rcon.port {:?}", value))?,
                "rcon.password" => password = value.to_string(),
                _ => {}
            }
        }
        if !enabled {
            bail!("enable-rcon is not true in {}", path);
        }
        if password.is_empty() {
            bail!("rcon.password is empty in {}", path);
        }
        Ok(Rcon { port, password })
    }

    fn connect(&self) -> Result<TcpStream> {
        let addr: SocketAddr = ([127, 0, 0, 1], self.port).into();
        let stream = TcpStream::connect_timeout(&addr, Duration::from_secs(3))
            .with_context(|| format!("connecting to RCON on {}", addr))?;
        stream.set_read_timeout(Some(Duration::from_secs(10)))?;
        stream.set_write_timeout(Some(Duration::from_secs(10)))?;
        Ok(stream)
    }

    /// Runs one command and returns the server's response text.
    fn command(&self, cmd: &str) -> Result<String> {
        let mut stream = self.connect()?;
        write_packet(&mut stream, 1, RCON_TYPE_LOGIN, &self.password)?;
        let (id, _, _) = read_packet(&mut stream).context("reading RCON login response")?;
        if id != 1 {
            bail!("RCON authentication failed (wrong password?)");
        }
        write_packet(&mut stream, 2, RCON_TYPE_COMMAND, cmd)?;
        let (id, ty, body) = read_packet(&mut stream).with_context(|| format!("reading RCON response to {:?}", cmd))?;
        if id != 2 || ty != RCON_TYPE_RESPONSE {
            bail!("unexpected RCON response: id={} type={} body={:?}", id, ty, body);
        }
        Ok(body)
    }
}

fn write_packet(stream: &mut TcpStream, id: i32, ty: i32, body: &str) -> Result<()> {
    let len = (4 + 4 + body.len() + 2) as i32;
    let mut buf = Vec::with_capacity(len as usize + 4);
    buf.extend_from_slice(&len.to_le_bytes());
    buf.extend_from_slice(&id.to_le_bytes());
    buf.extend_from_slice(&ty.to_le_bytes());
    buf.extend_from_slice(body.as_bytes());
    buf.extend_from_slice(&[0, 0]);
    stream.write_all(&buf)?;
    Ok(())
}

fn read_packet(stream: &mut TcpStream) -> Result<(i32, i32, String)> {
    let mut header = [0u8; 4];
    stream.read_exact(&mut header)?;
    let len = i32::from_le_bytes(header);
    if len < 10 || len as usize > RCON_MAX_PACKET {
        bail!("bad RCON packet length {}", len);
    }
    let len = len as usize;
    let mut buf = vec![0u8; len];
    stream.read_exact(&mut buf)?;
    let id = i32::from_le_bytes(buf[0..4].try_into()?);
    let ty = i32::from_le_bytes(buf[4..8].try_into()?);
    let body = String::from_utf8_lossy(&buf[8..len - 2]).into_owned();
    Ok((id, ty, body))
}

/// Parses the output of `list`.
///
/// 1.13+:  "There are 3 of a max of 20 players online: a, b, c"
/// 1.12.2: "There are 3/20 players online:\na, b, c"
fn parse_player_count(list_output: &str) -> Result<u64> {
    let marker = "There are ";
    let start = list_output
        .find(marker)
        .with_context(|| format!("unrecognised `list` output: {:?}", list_output))?
        + marker.len();
    let digits: String = list_output[start..].chars().take_while(|c| c.is_ascii_digit()).collect();
    digits.parse().with_context(|| format!("unrecognised `list` output: {:?}", list_output))
}

/// Seconds since the given process started, from /proc.
fn process_uptime(pid: u64) -> Result<Duration> {
    let stat = std::fs::read_to_string(format!("/proc/{}/stat", pid))?;
    // The comm field may contain spaces, so split after the closing paren.
    let after_comm = &stat[stat.rfind(')').context("malformed /proc/pid/stat")? + 1..];
    let fields: Vec<&str> = after_comm.split_whitespace().collect();
    // starttime is field 22 (1-indexed); the first field after ')' is field 3.
    let start_ticks: f64 = fields.get(19).context("short /proc/pid/stat")?.parse()?;
    let uptime = std::fs::read_to_string("/proc/uptime")?;
    let boot_uptime: f64 = uptime.split_whitespace().next().context("malformed /proc/uptime")?.parse()?;
    // /proc always reports in USER_HZ, which is 100 on Linux.
    let secs = boot_uptime - start_ticks / 100.0;
    Ok(Duration::from_secs_f64(secs.max(0.0)))
}

// Server toolbox
struct Server {
    rcon: Option<Rcon>,
    pid: u64,
}

impl Server {
    pub fn new() -> Result<Server> {
        let rcon = match Rcon::from_properties(SERVER_PROPERTIES) {
            Ok(rcon) => Some(rcon),
            Err(e) => {
                println!("RCON unavailable, commands will fail: {:#}", e);
                None
            }
        };
        let mut server = Server {
            rcon,
            pid: 0,
        };
        server.pid = server.get_pid()?;
        Ok(server)
    }

    pub fn players(&self) -> Result<u64> {
        let rcon = self.rcon.as_ref().context("RCON is not configured")?;
        parse_player_count(&rcon.command("list")?)
    }

    pub fn active_players(&self, afk: Duration) -> Result<u64> {
        let rcon = self.rcon.as_ref().context("RCON is not configured")?;
        let names = parse_player_names(&rcon.command("list")?);
        let rotations: Vec<(String, Option<String>)> = names
            .into_iter()
            .map(|name| {
                // Player names are [A-Za-z0-9_]; anything else is not queried, counts as active.
                let ok = !name.is_empty() && name.chars().all(|c| c.is_ascii_alphanumeric() || c == '_');
                let rotation = if ok {
                    rcon.command(&format!("data get entity {} Rotation", name))
                        .ok()
                        .filter(|r| r.contains("has the following entity data"))
                } else {
                    None
                };
                (name, rotation)
            })
            .collect();
        let old = std::fs::read_to_string(PLAYER_ACTIVITY).unwrap_or_default();
        let now = std::time::SystemTime::now().duration_since(std::time::UNIX_EPOCH)?.as_secs();
        let (active, memory) = judge_activity(&old, &rotations, now, afk.as_secs());
        std::fs::write(PLAYER_ACTIVITY, memory).context("writing player-activity.tsv")?;
        Ok(active)
    }

    /// Sends a console command over RCON.
    pub fn send(&mut self, command: &str) -> Result<()> {
        let rcon = self.rcon.as_ref().context("RCON is not configured")?;
        rcon.command(command)
            .with_context(|| format!("sending {:?} over RCON", command))?;
        Ok(())
    }

    fn get_pid(&self) -> Result<u64> {
        let pid = std::fs::read_to_string("server.pid")?.trim().parse()?;
        // Confirm it's running, and isn't a pun.
        let procslurp = std::fs::read_to_string(&format!(
                "/proc/{}/cmdline", pid))?;
        let cmdline: Vec<&str> = procslurp.split('\0').collect();
        if let Some(bash_param) = cmdline.get(1) {
            let actual = std::path::PathBuf::from(bash_param);
            let mut expected = std::env::current_dir()?;
            expected.push("server/start.py");

            if expected != actual {
                bail!("server.pid does not match a running Erisia instance");
            }
            return Ok(pid);
        } else {
            bail!("server.pid does not match a running Erisia instance");
        }
    }

    /// Returns false if `lazy` skipped the stop.
    pub fn stop(&mut self, grace_period: Duration, lazy: Option<Duration>) -> Result<bool> {
        // Check if we should stop at all.
        if let Some(lazy) = lazy {
            match process_uptime(self.pid) {
                Ok(uptime) if uptime < lazy => {
                    println!("Server has only been up for {} seconds, not stopping", uptime.as_secs());
                    return Ok(false);
                }
                Ok(_) => {}
                Err(e) => println!("Unable to read server uptime, stopping anyway: {:#}", e),
            }
        }
        // Build a queue of restart warnings to be emitted in the future.
        let start = Instant::now();
        let second = Duration::from_secs(1);
        let minute = Duration::from_secs(60);
        let mut warnings: Vec<(Instant, String)> = Vec::new();
        let mut remaining = Duration::from_secs(0);
        // These are inserted in reverse order from when they're emitted, starting at the end.
        while remaining < grace_period {
            if remaining < second * 30 {
                remaining += second * 10;
            } else if remaining < minute {
                remaining = minute;
            } else if remaining < minute * 10 {
                remaining += minute;
            } else {
                remaining += minute * 10;
            }
            if remaining > grace_period {
                remaining = grace_period;
            }
            let time = start + grace_period - remaining;
            if remaining >= minute {
                warnings.push((time,
                    format!("say Server restarting in {} minutes, or when empty",
                            remaining.as_secs() / 60)));
            } else {
                warnings.push((time,
                    format!("say Server restarting in {} seconds, or when empty",
                            remaining.as_secs())));
            }
        }
        // Earliest first.
        warnings.reverse();

        let mut last_player_check: Option<Instant> = None;
        while start.elapsed() < grace_period {
            // Poll the player count every few seconds; warnings every second.
            if last_player_check.map_or(true, |t| t.elapsed() >= second * 5) {
                last_player_check = Some(Instant::now());
                let players = match self.players() { Ok(n) => n, Err(e) => {
                    println!("Couldn't read player count, assuming non-empty: {:#}", e);
                    1
                }};
                if players == 0 {
                    println!("Server is empty, stopping now");
                    break;
                }
            }

            if warnings.first().map_or(false, |(time, _)| *time <= Instant::now()) {
                let (_, warning) = warnings.remove(0);
                self.send(&warning)?;
            }
            sleep(second);
        }

        println!("Stopping the server");
        self.send("save-on")?;
        self.send("save-all")?;
        sleep(second * 5);
        self.send("stop")?;

        // Wait until it's stopped.
        let stopping = Instant::now();
        while let Ok(current_pid) = self.get_pid() {
            if current_pid != self.pid {
                break;
            }
            sleep(second);
            if stopping.elapsed() >= second * 300 {
                println!("Server did not stop. Attempting to kill.");
                println!("Please manually confirm the state if this fails.");
                process::Command::new("kill").args(&[format!("{}", self.pid)]).output()?;
                break;
            }
        }
        Ok(true)
    }

    pub fn check(&self) -> Result<()> {
        // If we got this far then the server is running. Report on RCON too,
        // but don't fail: servers started before RCON was enabled won't have it.
        match self.players() {
            Ok(n) => println!("Server is running with {} player(s) online", n),
            Err(e) => println!("Server is running, but RCON is not working: {:#}", e),
        }
        Ok(())
    }
}

fn main() -> Result<()> {
    let opts: Opts = Opts::from_args();
    // Needs no running server: it only leaves a note for start.py.
    if let Command::RestartWhenEmpty { cancel, status } = opts.cmd {
        return restart_when_empty(cancel, status);
    }
    let mut server = Server::new()?;

    match opts.cmd {
        Command::Stop { time, lazy } => {
            let lazy = lazy.map(|lazy| Duration::from_secs(lazy * 3600));
            if !server.stop(Duration::from_secs(time), lazy)? {
                process::exit(EXIT_LAZY_SKIP);
            }
            Ok(())
        }
        Command::Check {} => server.check(),
        Command::Players {} => {
            println!("{}", server.players()?);
            Ok(())
        }
        Command::ActivePlayers { afk_minutes } => {
            println!("{}", server.active_players(Duration::from_secs(afk_minutes * 60))?);
            Ok(())
        }
        Command::RestartWhenEmpty { .. } => unreachable!(),
        Command::Say { message } => server.send(&format!("say {}", message.join(" "))),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn parses_modern_list_output() {
        assert_eq!(parse_player_count("There are 3 of a max of 20 players online: a, b, c").unwrap(), 3);
        assert_eq!(parse_player_count("There are 0 of a max of 20 players online: ").unwrap(), 0);
    }

    #[test]
    fn parses_legacy_list_output() {
        assert_eq!(parse_player_count("There are 12/20 players online:\na, b").unwrap(), 12);
    }

    #[test]
    fn parses_player_names() {
        assert_eq!(parse_player_names("There are 2 of a max of 20 players online: alice, bob_2"), vec!["alice", "bob_2"]);
        assert_eq!(parse_player_names("There are 0 of a max of 20 players online: "), Vec::<String>::new());
        assert_eq!(parse_player_names("There are 2/20 players online:\na, b"), vec!["a", "b"]);
    }

    #[test]
    fn judges_afk_by_unchanged_view() {
        let r = |n: &str, v: Option<&str>| (n.to_string(), v.map(|s| s.to_string()));
        // First sighting: active, remembered.
        let (n, mem) = judge_activity("", &[r("a", Some("[1f, 2f]"))], 1000, 600);
        assert_eq!(n, 1);
        // Same view 9 min later: still active; 10 min: AFK.
        assert_eq!(judge_activity(&mem, &[r("a", Some("[1f, 2f]"))], 1540, 600).0, 1);
        let (n, mem2) = judge_activity(&mem, &[r("a", Some("[1f, 2f]"))], 1600, 600);
        assert_eq!(n, 0);
        // Turning the view resets it.
        let (n, mem3) = judge_activity(&mem2, &[r("a", Some("[1.5f, 2f]"))], 1700, 600);
        assert_eq!(n, 1);
        assert!(mem3.contains("\t1700\n"));
        // Unreadable rotation counts as active; offline players are forgotten.
        let (n, mem4) = judge_activity(&mem2, &[r("b", None)], 1700, 600);
        assert_eq!(n, 1);
        assert_eq!(mem4, "");
    }

    #[test]
    fn rejects_garbage() {
        assert!(parse_player_count("Unknown command").is_err());
    }

    /// A fake RCON server that speaks the real wire protocol: checks the
    /// password, then answers `list` like a 1.21 server.
    fn fake_rcon_server(password: &'static str) -> u16 {
        use std::net::TcpListener;
        let listener = TcpListener::bind("127.0.0.1:0").unwrap();
        let port = listener.local_addr().unwrap().port();
        std::thread::spawn(move || {
            for stream in listener.incoming() {
                let mut stream = stream.unwrap();
                let (id, ty, body) = read_packet(&mut stream).unwrap();
                assert_eq!(ty, RCON_TYPE_LOGIN);
                if body != password {
                    write_packet(&mut stream, -1, RCON_TYPE_COMMAND, "").unwrap();
                    continue;
                }
                write_packet(&mut stream, id, RCON_TYPE_COMMAND, "").unwrap();
                let (id, ty, body) = read_packet(&mut stream).unwrap();
                assert_eq!(ty, RCON_TYPE_COMMAND);
                let reply = match body.as_str() {
                    "list" => "There are 2 of a max of 20 players online: alice, bob".to_string(),
                    other => format!("Unknown command: {}", other),
                };
                write_packet(&mut stream, id, RCON_TYPE_RESPONSE, &reply).unwrap();
            }
        });
        port
    }

    #[test]
    fn rcon_round_trip() {
        let port = fake_rcon_server("hunter2");
        let rcon = Rcon { port, password: "hunter2".to_string() };
        assert_eq!(parse_player_count(&rcon.command("list").unwrap()).unwrap(), 2);
        assert_eq!(rcon.command("say hi").unwrap(), "Unknown command: say hi");
    }

    #[test]
    fn rcon_rejects_bad_password() {
        let port = fake_rcon_server("hunter2");
        let rcon = Rcon { port, password: "wrong".to_string() };
        let err = rcon.command("list").unwrap_err().to_string();
        assert!(err.contains("authentication failed"), "{}", err);
    }

    #[test]
    fn reads_properties() {
        let dir = std::env::temp_dir().join(format!("control-test-{}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        let path = dir.join("server.properties");
        std::fs::write(&path, "#comment\nenable-rcon=true\nrcon.port=35565\nrcon.password=s3cret\nmotd=x=y\n").unwrap();
        let rcon = Rcon::from_properties(path.to_str().unwrap()).unwrap();
        assert_eq!(rcon.port, 35565);
        assert_eq!(rcon.password, "s3cret");
        std::fs::write(&path, "enable-rcon=false\nrcon.password=s3cret\n").unwrap();
        assert!(Rcon::from_properties(path.to_str().unwrap()).is_err());
        std::fs::remove_dir_all(&dir).unwrap();
    }

    #[test]
    fn reads_own_uptime() {
        let uptime = process_uptime(std::process::id() as u64).unwrap();
        assert!(uptime.as_secs() < 3600, "{:?}", uptime);
    }
}
