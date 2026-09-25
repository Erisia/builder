This directory is intended for files that are common to *all* servers, regardless of pack.

So, mostly start.py.

Supervision: on tsugumi, worlds are moving from tmux to machine-config's
`minecraft@WORLD` system units (run as the Minecraft user; stdin is the console
FIFO `/run/minecraft/WORLD.stdin`, output goes to the journal, `mc-console WORLD`
attaches). The unit sets `MINECRAFT_UNIT`, and then `start.py` launches Java
directly instead of in a `systemd-run --user` scope, skips the tmux session
check, and runs the extras (daily restart). `systemctl start|stop|restart
minecraft@WORLD` works as the Minecraft user. Until a world is cut over, it runs
in tmux as before.

Host shutdown uses `python3 ~/builder/shutdown.py`, run as the Minecraft user.
It discovers live `*/server.pid` launchers under that user's home, runs each
`control.sh stop -t 10` concurrently (bypassing `stop.sh`'s lazy uptime guard),
and waits for the original launchers to exit. `--list` only lists instances.
The caller must impose a timeout: tsugumi's `minecraft-shutdown.service` allows
60 seconds total, then kills the hook and continues normal system shutdown.

The hook leaves `/run/user/UID/minecraft-shutdown` to prevent automatic restarts.
The marker disappears on reboot. After a manual invocation or cancelled shutdown,
remove it explicitly before starting servers again. Normal NixOS switches do not
invoke the hook. Deploy `shutdown.py` and `update-and-start.sh` to the runtime
builder checkout together; the latter protects existing restart loops without
restarting the live server. New server builds also check the marker in `start.py`.

Crash analysis: when the Java process exits nonzero and the launcher did not
ask it to stop (ctrl-c/SIGTERM, the daily restart, or a host shutdown all set
that flag or marker first), `start.py` hands the exit to `crash_analysis.py`.
It snapshots `logs/latest.log`, the tail of `debug.log`, and any crash report
or `hs_err_pid*.log` written during that run into `crash-analysis/<stamp>/`,
then runs Claude Code detached (a `systemd-run --user` unit, or a plain
background process) with a suggestions-only prompt: it may read anything and
unpack or decompile mods in temp directories, but must not change the server.
The report is written atomically to `crash-analysis/<stamp>.md`; a failed or
timed-out run still produces a report saying so. At most three analyses start
per calendar day per server. `CRASH_ANALYSIS=0` in the launcher's environment
disables the feature; `CRASH_ANALYSIS_CLAUDE` overrides the binary (default
`~/.npm-global/bin/claude`, falling back to `claude` on PATH).
`tools/crash-analysis-notice.sh`, sourced from the shell rc files, lists unread
reports before every prompt until `crash-analysis-ack` is run.

Discord: when `~/.config/crash-analysis/discord.json` exists, the finished
report (including "analysis failed" reports) is also copied to
`~/web/crash-analysis/<server dir>/<stamp>.md` (e.g. `erisia/`), which Caddy serves at
`https://madoka.brage.info/crash-analysis/<server>/<stamp>.md`, and the
report's Summary section is posted to the webhook with that link. Only the
report is published, never the log snapshot. The file needs `webhook_url`;
`web_dir`, `public_url`, `username` and `avatar_url` are optional overrides.
`CRASH_ANALYSIS_DISCORD_CONFIG` points at a different config file. Publishing
is best effort: failures go to `crash-analysis/<stamp>/publish.log` and the
analyzer's stderr, and never affect the report itself.
