#!/usr/bin/env nix-shell
#!nix-shell -i python3 -p python3 python3Packages.psutil python3Packages.rich rsync tmux systemd

import os
import sys
import subprocess
import shutil
import time
import datetime
import threading
import signal
import glob
from pathlib import Path
import atexit
from rich.console import Console
from rich.panel import Panel
from rich.progress import Progress, SpinnerColumn, TextColumn, BarColumn, TimeElapsedColumn
from rich.table import Table
from rich.prompt import Confirm
from rich.logging import RichHandler
from rich.live import Live
from rich.text import Text

# --- Configuration ---
# BASE_DIR is the read-only directory where this script and its bundled resources reside (e.g., /nix/store/.../server)
BASE_DIR = Path(__file__).parent.resolve()
# APP_ROOT_DIR is the writable current working directory (e.g., /home/minecraft/erisia)
APP_ROOT_DIR = Path.cwd()

FORGE_JAR_PATTERN = 'forge/forge-*.jar' # Relative to BASE_DIR
TMUX_TARGET_SESSION_NAME = "@tmuxName@" # Placeholder
STOP_SCRIPT_PATH = APP_ROOT_DIR / "stop.sh" # stop.sh should be in the runtime dir if it's called
USER_JVM_ARGS_FILE = APP_ROOT_DIR / "user_jvm_args.txt" # JVM args also in runtime dir

# Runtime files in APP_ROOT_DIR
SERVER_PID_FILE = APP_ROOT_DIR / "server.pid" # Main script PID
SERVER_JVM_PID_FILE = APP_ROOT_DIR / "server-jvm.pid" # Java server PID (if not using systemd)
LOGS_DIR = APP_ROOT_DIR / "logs"
GC_LOG_PATH = APP_ROOT_DIR / "gc.log"

# --- Global State ---
java_server_process = None # Popen object for systemd-run or direct Java process
using_systemd = False
daily_restart_stop_event = threading.Event()
console = Console() # Global rich console instance


def setup_logging():
    """
    Set up rich logging for better console output.
    """
    global console
    if not sys.stdout.isatty():  # If output is not a TTY, disable colors
        os.environ["NO_COLOR"] = "1"
        console = Console(force_terminal=False, no_color=True)
    
    console.print(Panel.fit("Minecraft Server Startup Script", 
                           style="bold green", 
                           subtitle="Logging initialized"))


def run_command(cmd_list, check=True, cwd=None, **kwargs):
    """Helper to run a subprocess with rich output."""
    cmd_str = ' '.join(map(str, cmd_list))
    console.print(f"[bold blue]Running command:[/] [yellow]{cmd_str}[/] [dim](in {cwd or Path.cwd()})[/]")
    
    try:
        # For commands that might produce a lot of output, consider streaming
        # or capturing output more carefully if needed.
        return subprocess.run(cmd_list, check=check, cwd=cwd, text=True, **kwargs)
    except FileNotFoundError:
        console.print(f"[bold red]ERROR:[/] Command not found: {cmd_list[0]}")
        if check:
            sys.exit(1)
        return subprocess.CompletedProcess(cmd_list, -1, stderr=f"Command not found: {cmd_list[0]}")
    except subprocess.CalledProcessError as e:
        console.print(f"[bold red]ERROR:[/] Command '{cmd_str}' failed with exit code {e.returncode}")
        if e.stdout: console.print(f"[dim]Stdout:[/]\n{e.stdout}")
        if e.stderr: console.print(f"[red]Stderr:[/]\n{e.stderr}")
        if check:
            sys.exit(1)
        return e


def fix_permissions(path_to_fix_str):
    """Sets permissions for files and directories in APP_ROOT_DIR."""
    path_to_fix = Path(path_to_fix_str)
    if not path_to_fix.is_absolute():
        path_to_fix = APP_ROOT_DIR / path_to_fix

    if path_to_fix.is_symlink(): # Do not change permissions of symlinks themselves
        return

    if not path_to_fix.exists():
        console.print(f"[yellow]Warning:[/] Path does not exist, cannot fix permissions: {path_to_fix}")
        return

    # Simplified permission setting: make sure owner can read/write, group/others can read.
    # For directories, owner rwx, group/other rx.
    # This is a common, safer default than the original script's wide-open permissions.
    # User can adjust if more specific chmod logic is needed.
    try:
        if path_to_fix.is_file():
            # Owner rw, group r, other r (0o644)
            # The original was a+r (0o444), u+w (0o200) -> 0o644 effectively for owner if no other perms existed.
            path_to_fix.chmod(0o644)
        elif path_to_fix.is_dir():
            # Owner rwx, group rx, other rx (0o755)
            path_to_fix.chmod(0o755)
            for root, dirs, files in os.walk(path_to_fix):
                for d_name in dirs:
                    (Path(root) / d_name).chmod(0o755)
                for f_name in files:
                    (Path(root) / f_name).chmod(0o644)
    except Exception as e:
        console.print(f"[bold red]ERROR:[/] Failed to set permissions for {path_to_fix}: {e}")


def get_tmux_session_name():
    """Gets the current tmux session name."""
    try:
        result = run_command(['tmux', 'display-message', '-p', '#S'], capture_output=True, check=False)
        if result.returncode == 0:
            return result.stdout.strip()
        if result.stderr and "no server running on" in result.stderr:
            return "no server running"
        return None
    except Exception: # Includes FileNotFoundError if tmux isn't in PATH from run_command
        console.print("[yellow]tmux command not found or failed. Cannot check session.[/]")
        return "no server running"


def sync_server_files():
    """Synchronizes server files from BASE_DIR (Nix store) to APP_ROOT_DIR (runtime)."""
    with console.status("[bold green]Synchronizing server files...", spinner="dots"):
        # Items to rsync from BASE_DIR/ to APP_ROOT_DIR/
        # Original: rsync -acL server/$b . (where $b is config or world)
        # $BASE/server/$b -> $CWD/$b
        for item_name in ["config", "world"]:
            source_item = BASE_DIR / item_name
            dest_item = APP_ROOT_DIR / item_name
            if source_item.exists():
                console.print(f"Rsyncing [blue]{item_name}[/] from {source_item} to {dest_item}...")
                run_command(['rsync', '-acL', '--delete', str(source_item) + '/', str(dest_item)]) # Append / to source for content copy
            else:
                console.print(f"[yellow]Warning:[/] Source for {item_name} ({source_item}) not found. Skipping rsync.")
                dest_item.mkdir(parents=True, exist_ok=True) # Ensure dir exists

        # Items to symlink from BASE_DIR/ to APP_ROOT_DIR/
        # Original: ln -sf "$f" . (where $f is $BASE/$b, $b is forge or resources)
        # $BASE/$b -> $CWD/$b (symlink)
        # Then rsync "$f"/libraries . ($BASE/$b/libraries -> $CWD/libraries)
        for item_name in ["forge", "resources"]:
            source_dir = BASE_DIR / item_name # This is $f in original script
            dest_symlink = APP_ROOT_DIR / item_name

            if source_dir.exists(): # Symlink the directory itself
                console.print(f"Symlinking [blue]{source_dir}[/] to {dest_symlink}...")
                if dest_symlink.exists() or dest_symlink.is_symlink():
                    if dest_symlink.is_dir() and not dest_symlink.is_symlink():
                        shutil.rmtree(dest_symlink)
                    else:
                        dest_symlink.unlink()
                dest_symlink.symlink_to(source_dir, target_is_directory=source_dir.is_dir())

                # Rsync libraries from within the source_dir to APP_ROOT_DIR/libraries
                # Original: rsync -a "$f"/libraries .  (meaning $BASE/$item_name/libraries -> $CWD/libraries)
                libraries_source = source_dir / "libraries"
                libraries_dest = APP_ROOT_DIR / "libraries" # Explicit destination
                if libraries_source.is_dir():
                    console.print(f"Rsyncing libraries from [blue]{libraries_source}[/] to {libraries_dest}...")
                    libraries_dest.mkdir(parents=True, exist_ok=True)
                    run_command(['rsync', '-a', '--delete', str(libraries_source) + '/', str(libraries_dest)])
                # else: print(f"No libraries subdirectory found in {source_dir}")
            else:
                console.print(f"[yellow]Warning:[/] Source directory {source_dir} for symlinking not found. Skipping.")

        # *.properties, *.json: Copy from BASE_DIR to APP_ROOT_DIR if non-existent in APP_ROOT_DIR
        # Original: [[ -e "$b" ]] || cp -aL "$f" "$b"
        # $BASE/$b -> $CWD/$b
        for pattern in ["*.properties", "*.json"]:
            for source_file in BASE_DIR.glob(pattern):
                dest_file = APP_ROOT_DIR / source_file.name
                if not dest_file.exists():
                    console.print(f"Copying [blue]{source_file.name}[/] from {source_file} to {dest_file} (as it's non-existent)...")
                    shutil.copy2(source_file, dest_file, follow_symlinks=True) # follow_symlinks=True for -L effect

        # Default copy for other files from BASE_DIR to APP_ROOT_DIR
        # Original: [[ -e "$b" ]] && fixperms "$b" && rm -rf "$b"; cp -aL "$f" .
        # This needs to be selective. We don't want to copy everything from BASE_DIR.
        # The original script was iterating `BASE_DIR/*`.
        # Let's assume this was for specific additional files or templates.
        # For now, this is less clear what "other files" it means from the root of BASE_DIR.
        # If there are specific files like `eula.txt` or server icons, list them explicitly.
        # Example:
        # for explicit_file_name in ["eula.txt", "server-icon.png"]:
        #    source_f = BASE_DIR / explicit_file_name
        #    dest_f = APP_ROOT_DIR / explicit_file_name
        #    if source_f.exists():
        #        if dest_f.exists() or dest_f.is_symlink():
        #            fix_permissions(str(dest_f)) # Fix perms before removal
        #            if dest_f.is_dir() and not dest_f.is_symlink(): shutil.rmtree(dest_f)
        #            else: dest_f.unlink()
        #        shutil.copy2(source_f, dest_f, follow_symlinks=True)

        # The original script had a blanket `fixperms "$b"` for all processed $b (destination paths).
        # Let's ensure key destination directories have execute permissions if they were created.
        for key_dir in [APP_ROOT_DIR / "config", APP_ROOT_DIR / "world", APP_ROOT_DIR / "mods", LOGS_DIR]:
            if key_dir.is_dir(): # Check if it was actually created/synced
                fix_permissions(str(key_dir))


def daily_restart_task():
    """Thread task for daily restarts."""
    global java_server_process, using_systemd
    console.print("[green]Daily restart task started.[/]")
    while not daily_restart_stop_event.wait(45): # Wait 45s, check event
        now = datetime.datetime.now().strftime("%H:%M")
        if now in ["06:00", "18:00"]:
            console.print(f"[bold yellow]Scheduled restart triggered at {now}.[/]")
            
            if STOP_SCRIPT_PATH.is_file() and STOP_SCRIPT_PATH.stat().st_mode & 0o100: # Check if executable
                console.print(f"Running stop script for warnings: {STOP_SCRIPT_PATH}")
                run_command([str(STOP_SCRIPT_PATH)], check=False, cwd=APP_ROOT_DIR)
            else:
                console.print(f"[yellow]Stop script {STOP_SCRIPT_PATH} not found or not executable. Skipping player warnings via stop.sh.[/]")
            
            # The thread can now exit. Main script termination will be handled by java_server_process exiting.
            break
    console.print("[green]Daily restart task finishing.[/]")


def kill_java_process_fallback(pid, timeout_sec=180):
    """Fallback to psutil for killing process tree if not using systemd."""
    try:
        import psutil
    except ImportError:
        console.print("[bold red]ERROR:[/] psutil not installed. Cannot perform robust process tree killing in fallback mode.")
        # As an absolute last resort, try os.kill if we have a direct Popen object
        if java_server_process and java_server_process.pid == pid:
             try: os.kill(pid, signal.SIGTERM)
             except OSError: pass
             time.sleep(10) # Short wait
             try: os.kill(pid, signal.SIGKILL)
             except OSError: pass
        return

    if not psutil.pid_exists(pid):
        console.print(f"[yellow]Process {pid} not found for killing (psutil).[/]")
        return

    try:
        parent = psutil.Process(pid)
        children = parent.children(recursive=True)
        procs_to_kill = children + [parent] # Kill parent last might be better, but for TERM/KILL this is fine.

        with console.status(f"[bold red]Terminating process {pid} and its children...", spinner="dots"):
            for p in procs_to_kill:
                try:
                    console.print(f"Sending SIGTERM to process [cyan]{p.pid}[/] ([cyan]{p.name()}[/])")
                    p.terminate()
                except psutil.NoSuchProcess:
                    continue
                except Exception as e:
                    console.print(f"[yellow]Warning:[/] Error sending SIGTERM to {p.pid}: {e}")

            gone, alive = psutil.wait_procs(procs_to_kill, timeout=timeout_sec)

            for p in alive:
                console.print(f"[bold red]Process {p.pid} ({p.name()}) did not terminate after {timeout_sec}s, sending SIGKILL.[/]")
                try:
                    p.kill()
                except psutil.NoSuchProcess:
                    pass # Already gone
                except Exception as e:
                    console.print(f"[bold red]ERROR:[/] Failed to SIGKILL {p.pid}: {e}")
    except psutil.NoSuchProcess:
        console.print(f"[yellow]Process {pid} disappeared during psutil cleanup.[/]")
    except Exception as e:
        console.print(f"[bold red]ERROR:[/] Exception during psutil process tree killing for PID {pid}: {e}")


_cleanup_has_run = False
def cleanup_handler():
    """Registered with atexit and called on SIGTERM to this script."""
    global _cleanup_has_run, java_server_process, using_systemd
    if _cleanup_has_run:
        return
    _cleanup_has_run = True

    console.print("[bold yellow]Cleanup handler activated...[/]")
    daily_restart_stop_event.set() # Stop daily restart thread

    if using_systemd:
        console.print(f"Instructing systemd to stop the server scope: [cyan]minecraft-server-{TMUX_TARGET_SESSION_NAME}.scope[/]")
        # systemd will handle TimeoutStopSec (3 minutes) and SIGKILL if needed.
        run_command(['systemctl', '--user', 'stop', f'minecraft-server-{TMUX_TARGET_SESSION_NAME}.scope'], check=False)
        # We don't need to manage the java_server_process directly here as systemd handles it.
        # The main script's wait on systemd-run will unblock when the unit stops.
    elif java_server_process and java_server_process.pid:
        pid = java_server_process.pid
        with console.status(f"[bold yellow]Attempting graceful shutdown of Java process {pid}...", spinner="dots"):
            console.print(f"[yellow]Attempting graceful shutdown of direct Java process {pid} (3 min timeout)...[/]")
            if java_server_process.poll() is None: # Still running
                java_server_process.terminate() # Send SIGTERM
                try:
                    java_server_process.wait(timeout=180) # Wait 3 minutes
                    console.print(f"[green]Java process {pid} terminated gracefully.[/]")
                except subprocess.TimeoutExpired:
                    console.print(f"[bold red]Java process {pid} did not terminate after 3 minutes. Attempting SIGKILL via psutil.[/]")
                    kill_java_process_fallback(pid, timeout_sec=0) # psutil will term then kill
                except Exception as e:
                    console.print(f"[bold red]ERROR during java_server_process.wait: {e}. Attempting SIGKILL via psutil for {pid}.[/]")
                    kill_java_process_fallback(pid, timeout_sec=0)
            else:
                console.print(f"[green]Java process {pid} was already stopped.[/]")
    else:
        console.print("[yellow]No active Java server process tracked by this script for cleanup.[/]")

    # Fallback check for server-jvm.pid file, in case this script died and an old PID file exists.
    if SERVER_JVM_PID_FILE.exists():
        try:
            stored_jvm_pid = int(SERVER_JVM_PID_FILE.read_text().strip())
            console.print(f"[yellow]Found lingering JVM PID {stored_jvm_pid} in {SERVER_JVM_PID_FILE}. Attempting to kill its tree via psutil.[/]")
            kill_java_process_fallback(stored_jvm_pid) # Use standard 3-min timeout
        except ValueError:
            console.print(f"[yellow]Warning:[/] Could not parse PID from {SERVER_JVM_PID_FILE}.")
        except Exception as e:
            console.print(f"[yellow]Warning:[/] Error processing {SERVER_JVM_PID_FILE}: {e}")
        finally:
            SERVER_JVM_PID_FILE.unlink(missing_ok=True)

    if SERVER_PID_FILE.exists():
        SERVER_PID_FILE.unlink(missing_ok=True)

    console.print("[green]Cleanup finished.[/]")


def signal_receiver(signum, frame):
    signal_name = signal.Signals(signum).name
    console.print(f"\n[bold red]Signal {signal_name} ({signum}) received. Initiating shutdown sequence...[/]")
    # The atexit handler (cleanup_handler) will perform the actual cleanup.
    # We just need to ensure the script terminates, which will trigger atexit.
    # If this signal handler is called, it means the main loop might be stuck.
    # Raising SystemExit ensures atexit runs.
    sys.exit(128 + signum)


def check_systemd():
    """Check for systemd-run and systemctl."""
    return shutil.which("systemd-run") and shutil.which("systemctl")


def main():
    global java_server_process, using_systemd

    setup_logging()
    atexit.register(cleanup_handler)
    signal.signal(signal.SIGTERM, signal_receiver)
    signal.signal(signal.SIGINT, signal_receiver)
    signal.signal(signal.SIGHUP, signal_receiver)

    # Save this script's PID
    SERVER_PID_FILE.write_text(str(os.getpid()))

    # Display a server info table
    server_info = Table(title="Minecraft Server Startup")
    server_info.add_column("Component", style="cyan")
    server_info.add_column("Value", style="green")
    server_info.add_row("Base Directory", str(BASE_DIR))
    server_info.add_row("Runtime Directory", str(APP_ROOT_DIR))
    server_info.add_row("Tmux Session", TMUX_TARGET_SESSION_NAME)
    server_info.add_row("Logs Directory", str(LOGS_DIR))
    server_info.add_row("PID File", str(SERVER_PID_FILE))
    server_info.add_row("Script PID", str(os.getpid()))
    console.print(server_info)

    if check_systemd():
        console.print("[green]systemd detected. Will use systemd-run for managing the server process.[/]")
        using_systemd = True
    else:
        console.print("[yellow]Warning:[/] systemd not detected. Falling back to direct process management. Robust cleanup might be impaired.")
        using_systemd = False
        try:
            import psutil # Check if psutil is available for fallback
        except ImportError:
            console.print("[bold red]ERROR:[/] psutil package is not installed. Fallback process cleanup will be very limited. Please install psutil (`nix-shell -p python3Packages.psutil`)")
            # sys.exit(1) # Or allow to continue with very basic cleanup

    # Tmux check for extras
    run_extras = False
    skip_tmux_env = os.environ.get("SKIP_TMUX")
    if not skip_tmux_env:
        session_name = get_tmux_session_name()
        if session_name == "no server running":
            console.print("[yellow]Warning:[/] Not running inside a tmux session, or tmux is unavailable.")
            console.print("[yellow]Maintenance scripts (like daily restart) will not be run.[/]")
        elif session_name == TMUX_TARGET_SESSION_NAME:
            console.print(f"[green]Running in correct tmux session: {session_name}. Extras enabled.[/]")
            run_extras = True
        else:
            console.print(f"[bold red]ERROR:[/] Expected tmux session '{TMUX_TARGET_SESSION_NAME}', found '{session_name}'. Aborting.")
            sys.exit(1)
    else:
        console.print("[yellow]SKIP_TMUX is set. Skipping tmux check; extras disabled.[/]")

    # Create essential directories in APP_ROOT_DIR
    LOGS_DIR.mkdir(parents=True, exist_ok=True)
    (APP_ROOT_DIR / "mods").mkdir(parents=True, exist_ok=True) # Ensure mods dir exists for prometheus check

    with Progress(
        SpinnerColumn(),
        TextColumn("[bold blue]{task.description}"),
        BarColumn(),
        TimeElapsedColumn(),
    ) as progress:
        sync_task = progress.add_task("[green]Synchronizing server files...", total=1)
        sync_server_files()
        progress.update(sync_task, completed=1)

        gc_task = progress.add_task("[yellow]Cleaning up GC log...", total=1)
        GC_LOG_PATH.unlink(missing_ok=True)
        progress.update(gc_task, completed=1)

    if run_extras:
        console.print("[green]Starting daily restart thread.[/]")
        threading.Thread(target=daily_restart_task, daemon=True).start()

    web_deploy_script = Path.home() / "web" / "deploy.sh"
    if web_deploy_script.is_file() and web_deploy_script.stat().st_mode & 0o100:
        console.print(f"[blue]Running web deployment script: {web_deploy_script}[/]")
        run_command([str(web_deploy_script)], check=False, cwd=Path.home() / "web")

    world_log = LOGS_DIR / "world.log"
    if world_log.exists():
        console.print(f"[blue]Compressing previous world log: {world_log}[/]")
        world_log_gz = LOGS_DIR / "world.log.gz"
        try:
            with open(world_log, 'rb') as f_in, open(world_log_gz, 'ab') as f_out:
                subprocess.run(['gzip', '-c'], stdin=f_in, stdout=f_out, check=True)
            world_log.unlink()
            console.print(f"[green]Compressed log to {world_log_gz}[/]")
        except Exception as e:
            console.print(f"[bold red]ERROR compressing world log: {e}[/]")

    if os.environ.get("KILL_PROMETHEUS") == "1":
        console.print("[yellow]KILL_PROMETHEUS is set. Removing Prometheus integration mods...[/]")
        for mod_path in (APP_ROOT_DIR / "mods").glob("prometheus-integration-*.jar"):
            console.print(f"[yellow]Removing mod: {mod_path}[/]")
            mod_path.unlink(missing_ok=True)

    jvm_args_from_file = []
    if USER_JVM_ARGS_FILE.is_file():
        try:
            jvm_args_from_file = USER_JVM_ARGS_FILE.read_text().strip().split()
            console.print(f"[blue]Loaded JVM args from {USER_JVM_ARGS_FILE}:[/] [cyan]{' '.join(jvm_args_from_file)}[/]")
        except Exception as e:
            console.print(f"[yellow]Warning:[/] Could not read/parse {USER_JVM_ARGS_FILE}: {e}")

    # --- Server Startup Command Construction ---
    java_exec_command = ['java'] # This will be prefixed by `nix shell`
    
    # Determine server type and JRE
    fabric_dir_in_base = BASE_DIR / "fabric"
    fabric_launcher_in_base = fabric_dir_in_base / "fabric-launcher.jar"
    forge_run_script_in_base = BASE_DIR / "forge" / "run.sh"
    cleanroom_jars_in_base = list((BASE_DIR / "forge").glob("cleanroom-*.jar"))

    nix_jre_package = "jre" # Default to latest for modern servers
    server_specific_args = []

    # Create a server type info panel
    server_type_panel = None

    if fabric_dir_in_base.is_dir() and fabric_launcher_in_base.is_file():
        server_type_panel = Panel(
            "[bold]Fabric Server[/]\nUsing JRE: Latest",
            style="green"
        )
        nix_jre_package = "jre"
        server_specific_args = ['-jar', str(fabric_launcher_in_base), 'nogui']
    elif forge_run_script_in_base.is_file():
        server_type_panel = Panel(
            "[bold]Forge 1.18+ Server[/]\nUsing run.sh script\nJRE: Latest",
            style="green"
        )
        nix_jre_package = "jre"
        # run.sh handles its own args, including user_jvm_args.txt implicitly.
        # So, we just provide the script to `nix shell ... --command`.
        # The `java_exec_command` will become the path to run.sh.
        java_exec_command = [str(forge_run_script_in_base)]
        jvm_args_from_file = [] # run.sh handles this
    elif cleanroom_jars_in_base:
        selected_cleanroom_jar = sorted(cleanroom_jars_in_base, reverse=True)[0]
        server_type_panel = Panel(
            f"[bold]Cleanroom Server[/]\nJAR: {selected_cleanroom_jar.name}\nJRE: Latest",
            style="green"
        )
        nix_jre_package = "jre"
        server_specific_args = ['-jar', str(selected_cleanroom_jar), 'nogui']
    else:
        # Check for older Forge
        forge_jars_in_base = list(BASE_DIR.glob(FORGE_JAR_PATTERN))
        if forge_jars_in_base:
            actual_forge_jar = sorted(forge_jars_in_base, reverse=True)[0]
            server_type_panel = Panel(
                f"[bold]Older Forge Server[/]\nJAR: {actual_forge_jar.name}\nJRE: Java 8",
                style="yellow"
            )
            nix_jre_package = "jre8"
            
            base_jvm_args = [
                '-XX:+UnlockExperimentalVMOptions', '-XX:+AggressiveOpts',
                '-XX:+UseG1GC', '-XX:G1HeapRegionSize=32M',
                '-XX:G1NewSizePercent=20', '-XX:+UseAdaptiveGCBoundary'
            ]
            # Prepend base_jvm_args to user-provided ones for this specific case
            jvm_args_from_file = base_jvm_args + jvm_args_from_file
            server_specific_args = ['-jar', str(actual_forge_jar), 'nogui']
        else:
            server_type_panel = Panel(
                "[bold red]Unknown Server Type[/]\nNo recognized server JARs found",
                style="red"
            )
            console.print(f"[bold red]ERROR: No Forge JAR found in {BASE_DIR} matching '{FORGE_JAR_PATTERN}'[/]")
            sys.exit(1)

    # Display the server type panel
    if server_type_panel:
        console.print(server_type_panel)

    # Construct the full command line
    if java_exec_command[0] == 'java': # If we are calling java directly (not run.sh)
        full_java_command = java_exec_command + jvm_args_from_file + server_specific_args
    else: # We are calling a script like run.sh, which takes over argument parsing
        full_java_command = java_exec_command + jvm_args_from_file + server_specific_args

    # Prefix with `nix shell`
    final_command_to_run = ['nix', 'shell', f'nixpkgs#{nix_jre_package}', '--command'] + full_java_command
    
    scope_name = f'minecraft-server-{TMUX_TARGET_SESSION_NAME}.scope'
    if using_systemd:
        final_command_to_run = [
            'systemd-run', '--user', '--scope', '--collect',
            '--unit=' + scope_name,
            '-p', 'TimeoutStopSec=180s' # 3 minutes
            # Potentially set nice, OOMScoreAdjust, CPUQuota, MemoryMax etc. here via -p
        ] + final_command_to_run

    console.print(Panel(f"[bold cyan]Command:[/] [yellow]{' '.join(final_command_to_run)}[/]", 
                   title="Server Startup Command", 
                   subtitle=f"CWD: {APP_ROOT_DIR}"))

    try:
        # Environment for the subprocess - could be useful for nix shell if it needs specific vars
        env = os.environ.copy()
        
        java_server_process = subprocess.Popen(final_command_to_run, cwd=APP_ROOT_DIR, env=env)
        
        if not using_systemd: # If direct Popen, save its PID
            console.print(f"[green]Java server process (direct) started with PID: {java_server_process.pid}[/]")
            SERVER_JVM_PID_FILE.write_text(str(java_server_process.pid))
        else:
            console.print(f"[green]systemd-run process started with PID: {java_server_process.pid}. Server runs in scope: {scope_name}[/]")

        # Create a panel to show the startup status
        startup_panel = Panel(
            f"[green]Server starting...[/]\n[cyan]Waiting for process to complete[/]",
            title="Server Status",
            border_style="green"
        )
        console.print(startup_panel)
        
        # Wait for process to complete
        return_code = java_server_process.wait()

        # Display final status
        if return_code == 0:
            console.print(Panel(f"[green]Server has shut down gracefully[/]", 
                           title="Server Status", 
                           border_style="green"))
        else:
            console.print(Panel(f"[red]Server has shut down with return code {return_code}[/]", 
                           title="Server Status", 
                           border_style="red"))

        if using_systemd:
            console.print(f"[blue]systemd-run for {scope_name} exited with code {return_code}.[/]")
            # Check scope status for more info if needed: systemctl status scope_name
        else:
            console.print(f"[blue]Java server process {java_server_process.pid if java_server_process else 'N/A'} exited with code {return_code}.[/]")

    except FileNotFoundError:
        console.print(f"[bold red]ERROR: Could not execute command. Ensure nix, systemd-run (if applicable), or java is available: {final_command_to_run[0]}[/]")
        sys.exit(1)
    except Exception as e:
        console.print(f"[bold red]ERROR: An unexpected error occurred while starting or managing the server: {e}[/]")
        sys.exit(1)
    finally:
        # The atexit handler (cleanup_handler) will run here if the script exits.
        # No need to call cleanup_handler explicitly unless it's a very specific scenario.
        console.print("[green]Server process has finished. Main script is exiting.[/]")

if __name__ == "__main__":
    main()
