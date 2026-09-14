This directory is intended for files that are common to *all* servers, regardless of pack.

So, mostly start.py.

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
