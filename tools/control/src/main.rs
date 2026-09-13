//! Server control tool.
//!
//! Talks to the running Minecraft server over RCON (vanilla, works on every
//! Minecraft version) to read the player count and to send commands. The
//! RCON port and password are read from ./server.properties, which start.py
//! rewrites with a fresh random password on every launch.
//!
//! If RCON is unavailable (e.g. a server started before RCON was enabled),
//! commands fall back to tmux send-keys, and the player count is assumed to
//! be non-zero so restarts still wait out their grace period.

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
    #[structopt(name = "server", help = "Which server (tmux name) to work on")]
    server: String,

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
    /// Send a chat message to everyone on the server.
    Say {
        #[structopt(name = "message", required = true)]
        message: Vec<String>,
    },
}

const SERVER_PROPERTIES: &str = "server.properties";

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
    tmux_id: String,
    rcon: Option<Rcon>,
    pid: u64,
}

impl Server {
    pub fn new(tmux_id: String) -> Result<Server> {
        let rcon = match Rcon::from_properties(SERVER_PROPERTIES) {
            Ok(rcon) => Some(rcon),
            Err(e) => {
                println!("RCON unavailable, falling back to tmux: {:#}", e);
                None
            }
        };
        let mut server = Server {
            tmux_id,
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

    /// Sends a console command, over RCON if possible, otherwise via tmux.
    pub fn send(&mut self, command: &str) -> Result<()> {
        if let Some(rcon) = &self.rcon {
            match rcon.command(command) {
                Ok(_) => return Ok(()),
                Err(e) => println!("RCON failed for {:?}, falling back to tmux: {:#}", command, e),
            }
        }
        self.send_tmux(command)
    }

    fn send_tmux(&self, command: &str) -> Result<()> {
        std::process::Command::new("tmux")
            .args(&[
                "send-keys",
                "-t",
                &format!("{}:0", self.tmux_id),
                command,
                "ENTER",
            ])
            .output()?;
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

    // Stop command
    pub fn stop(&mut self, grace_period: Duration, lazy: Option<Duration>) -> Result<()> {
        // Check if we should stop at all.
        if let Some(lazy) = lazy {
            match process_uptime(self.pid) {
                Ok(uptime) if uptime < lazy => {
                    println!("Server has only been up for {} seconds, not stopping", uptime.as_secs());
                    return Ok(());
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

        println!("Stopping {}", self.tmux_id);
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
        return Ok(());
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
    let mut server = Server::new(opts.server.to_owned())?;

    match opts.cmd {
        Command::Stop { time, lazy } => server.stop(Duration::from_secs(time), lazy.map(
            |lazy| Duration::from_secs(lazy * 3600)
        )),
        Command::Check {} => server.check(),
        Command::Players {} => {
            println!("{}", server.players()?);
            Ok(())
        }
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
