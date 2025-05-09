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


def setup_logging():
    """
    Placeholder for setting up more advanced logging.
    For now, all output goes to stdout/stderr.
    Consider libraries like 'rich' or 'coloredlogs' for fancier output.
    Example with rich:
    from rich.console import Console
    console = Console()
    # then use console.print, console.log
    """
    if not sys.stdout.isatty(): # If output is not a TTY, disable colors
        os.environ["NO_COLOR"] = "1"
        # For rich, you might need: console = Console(force_terminal=False, no_color=True)
    print("Logging to console.", flush=True)


def run_command(cmd_list, check=True, cwd=None, **kwargs):
    """Helper to run a subprocess."""
    cmd_str = ' '.join(map(str, cmd_list))
    print(f"Running command: {cmd_str} (in {cwd or Path.cwd()})", flush=True)
    try:
        # For commands that might produce a lot of output, consider streaming
        # or capturing output more carefully if needed.
        return subprocess.run(cmd_list, check=check, cwd=cwd, text=True, **kwargs)
    except FileNotFoundError:
        print(f"ERROR: Command not found: {cmd_list[0]}", file=sys.stderr, flush=True)
        if check:
            sys.exit(1)
        return subprocess.CompletedProcess(cmd_list, -1, stderr=f"Command not found: {cmd_list[0]}")
    except subprocess.CalledProcessError as e:
        print(f"ERROR: Command '{cmd_str}' failed with exit code {e.returncode}", file=sys.stderr, flush=True)
        if e.stdout: print(f"Stdout:\n{e.stdout}", file=sys.stderr, flush=True)
        if e.stderr: print(f"Stderr:\n{e.stderr}", file=sys.stderr, flush=True)
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
        print(f"Warning: Path does not exist, cannot fix permissions: {path_to_fix}", flush=True)
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
        print(f"ERROR: Failed to set permissions for {path_to_fix}: {e}", file=sys.stderr, flush=True)


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
        print("tmux command not found or failed. Cannot check session.", file=sys.stderr, flush=True)
        return "no server running"


def sync_server_files():
    """Synchronizes server files from BASE_DIR (Nix store) to APP_ROOT_DIR (runtime)."""
    print(f"Synchronizing server files from {BASE_DIR} to {APP_ROOT_DIR}...", flush=True)

    # Items to rsync from BASE_DIR/ to APP_ROOT_DIR/
    # Original: rsync -acL server/$b . (where $b is config or world)
    # $BASE/server/$b -> $CWD/$b
    for item_name in ["config", "world"]:
        source_item = BASE_DIR / item_name
        dest_item = APP_ROOT_DIR / item_name
        if source_item.exists():
            print(f"Rsyncing {item_name} from {source_item} to {dest_item}...", flush=True)
            run_command(['rsync', '-acL', '--delete', str(source_item) + '/', str(dest_item)]) # Append / to source for content copy
        else:
            print(f"Warning: Source for {item_name} ({source_item}) not found. Skipping rsync.", flush=True)
            dest_item.mkdir(parents=True, exist_ok=True) # Ensure dir exists

    # Items to symlink from BASE_DIR/ to APP_ROOT_DIR/
    # Original: ln -sf "$f" . (where $f is $BASE/$b, $b is forge or resources)
    # $BASE/$b -> $CWD/$b (symlink)
    # Then rsync "$f"/libraries . ($BASE/$b/libraries -> $CWD/libraries)
    for item_name in ["forge", "resources"]:
        source_dir = BASE_DIR / item_name # This is $f in original script
        dest_symlink = APP_ROOT_DIR / item_name

        if source_dir.exists(): # Symlink the directory itself
            print(f"Symlinking {source_dir} to {dest_symlink}...", flush=True)
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
                print(f"Rsyncing libraries from {libraries_source} to {libraries_dest}...", flush=True)
                libraries_dest.mkdir(parents=True, exist_ok=True)
                run_command(['rsync', '-a', '--delete', str(libraries_source) + '/', str(libraries_dest)])
            # else: print(f"No libraries subdirectory found in {source_dir}")
        else:
            print(f"Warning: Source directory {source_dir} for symlinking not found. Skipping.", flush=True)

    # *.properties, *.json: Copy from BASE_DIR to APP_ROOT_DIR if non-existent in APP_ROOT_DIR
    # Original: [[ -e "$b" ]] || cp -aL "$f" "$b"
    # $BASE/$b -> $CWD/$b
    for pattern in ["*.properties", "*.json"]:
        for source_file in BASE_DIR.glob(pattern):
            dest_file = APP_ROOT_DIR / source_file.name
            if not dest_file.exists():
                print(f"Copying {source_file.name} from {source_file} to {dest_file} (as it's non-existent)...", flush=True)
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
    print("Daily restart task started.", flush=True)
    while not daily_restart_stop_event.wait(45): # Wait 45s, check event
        now = datetime.datetime.now().strftime("%H:%M")
        if now in ["06:00", "18:00"]:
            print(f"Scheduled restart triggered at {now}.", flush=True)
            
            if STOP_SCRIPT_PATH.is_file() and STOP_SCRIPT_PATH.stat().st_mode & 0o100: # Check if executable
                print(f"Running stop script for warnings: {STOP_SCRIPT_PATH}", flush=True)
                run_command([str(STOP_SCRIPT_PATH)], check=False, cwd=APP_ROOT_DIR)
            else:
                print(f"Stop script {STOP_SCRIPT_PATH} not found or not executable. Skipping player warnings via stop.sh.", flush=True)
            
            # The thread can now exit. Main script termination will be handled by java_server_process exiting.
            break
    print("Daily restart task finishing.", flush=True)

def kill_java_process_fallback(pid, timeout_sec=180):
    """Fallback to psutil for killing process tree if not using systemd."""
    try:
        import psutil
    except ImportError:
        print("ERROR: psutil not installed. Cannot perform robust process tree killing in fallback mode.", file=sys.stderr, flush=True)
        # As an absolute last resort, try os.kill if we have a direct Popen object
        if java_server_process and java_server_process.pid == pid:
             try: os.kill(pid, signal.SIGTERM)
             except OSError: pass
             time.sleep(10) # Short wait
             try: os.kill(pid, signal.SIGKILL)
             except OSError: pass
        return

    if not psutil.pid_exists(pid):
        print(f"Process {pid} not found for killing (psutil).", flush=True)
        return

    try:
        parent = psutil.Process(pid)
        children = parent.children(recursive=True)
        procs_to_kill = children + [parent] # Kill parent last might be better, but for TERM/KILL this is fine.

        for p in procs_to_kill:
            try:
                print(f"Sending SIGTERM to process {p.pid} ({p.name()})", flush=True)
                p.terminate()
            except psutil.NoSuchProcess:
                continue
            except Exception as e:
                print(f"Warning: Error sending SIGTERM to {p.pid}: {e}", file=sys.stderr, flush=True)

        gone, alive = psutil.wait_procs(procs_to_kill, timeout=timeout_sec)

        for p in alive:
            print(f"Process {p.pid} ({p.name()}) did not terminate after {timeout_sec}s, sending SIGKILL.", flush=True)
            try:
                p.kill()
            except psutil.NoSuchProcess:
                pass # Already gone
            except Exception as e:
                print(f"ERROR: Failed to SIGKILL {p.pid}: {e}", file=sys.stderr, flush=True)
    except psutil.NoSuchProcess:
        print(f"Process {pid} disappeared during psutil cleanup.", flush=True)
    except Exception as e:
        print(f"ERROR: Exception during psutil process tree killing for PID {pid}: {e}", file=sys.stderr, flush=True)


_cleanup_has_run = False
def cleanup_handler():
    """Registered with atexit and called on SIGTERM to this script."""
    global _cleanup_has_run, java_server_process, using_systemd
    if _cleanup_has_run:
        return
    _cleanup_has_run = True

    print("Cleanup handler activated...", flush=True)
    daily_restart_stop_event.set() # Stop daily restart thread

    if using_systemd:
        print(f"Instructing systemd to stop the server scope: minecraft-server-{TMUX_TARGET_SESSION_NAME}.scope", flush=True)
        # systemd will handle TimeoutStopSec (3 minutes) and SIGKILL if needed.
        run_command(['systemctl', '--user', 'stop', f'minecraft-server-{TMUX_TARGET_SESSION_NAME}.scope'], check=False)
        # We don't need to manage the java_server_process directly here as systemd handles it.
        # The main script's wait on systemd-run will unblock when the unit stops.
    elif java_server_process and java_server_process.pid:
        pid = java_server_process.pid
        print(f"Attempting graceful shutdown of direct Java process {pid} (3 min timeout)...", flush=True)
        if java_server_process.poll() is None: # Still running
            java_server_process.terminate() # Send SIGTERM
            try:
                java_server_process.wait(timeout=180) # Wait 3 minutes
                print(f"Java process {pid} terminated gracefully.", flush=True)
            except subprocess.TimeoutExpired:
                print(f"Java process {pid} did not terminate after 3 minutes. Attempting SIGKILL via psutil.", file=sys.stderr, flush=True)
                kill_java_process_fallback(pid, timeout_sec=0) # psutil will term then kill
            except Exception as e:
                print(f"ERROR during java_server_process.wait: {e}. Attempting SIGKILL via psutil for {pid}.", file=sys.stderr, flush=True)
                kill_java_process_fallback(pid, timeout_sec=0)
        else:
            print(f"Java process {pid} was already stopped.", flush=True)
    else:
        print("No active Java server process tracked by this script for cleanup.", flush=True)

    # Fallback check for server-jvm.pid file, in case this script died and an old PID file exists.
    if SERVER_JVM_PID_FILE.exists():
        try:
            stored_jvm_pid = int(SERVER_JVM_PID_FILE.read_text().strip())
            print(f"Found lingering JVM PID {stored_jvm_pid} in {SERVER_JVM_PID_FILE}. Attempting to kill its tree via psutil.", flush=True)
            kill_java_process_fallback(stored_jvm_pid) # Use standard 3-min timeout
        except ValueError:
            print(f"Warning: Could not parse PID from {SERVER_JVM_PID_FILE}.", file=sys.stderr, flush=True)
        except Exception as e:
            print(f"Warning: Error processing {SERVER_JVM_PID_FILE}: {e}", file=sys.stderr, flush=True)
        finally:
            SERVER_JVM_PID_FILE.unlink(missing_ok=True)

    if SERVER_PID_FILE.exists():
        SERVER_PID_FILE.unlink(missing_ok=True)

    print("Cleanup finished.", flush=True)


def signal_receiver(signum, frame):
    signal_name = signal.Signals(signum).name
    print(f"\nSignal {signal_name} ({signum}) received. Initiating shutdown sequence...", flush=True)
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

    if check_systemd():
        print("systemd detected. Will use systemd-run for managing the server process.", flush=True)
        using_systemd = True
    else:
        print("Warning: systemd not detected. Falling back to direct process management. Robust cleanup might be impaired.", file=sys.stderr, flush=True)
        using_systemd = False
        try:
            import psutil # Check if psutil is available for fallback
        except ImportError:
            print("ERROR: psutil package is not installed. Fallback process cleanup will be very limited. Please install psutil (`nix-shell -p python3Packages.psutil`)", file=sys.stderr, flush=True)
            # sys.exit(1) # Or allow to continue with very basic cleanup

    # Tmux check for extras
    run_extras = False
    skip_tmux_env = os.environ.get("SKIP_TMUX")
    if not skip_tmux_env:
        session_name = get_tmux_session_name()
        if session_name == "no server running":
            print("Warning: Not running inside a tmux session, or tmux is unavailable.", flush=True)
            print("Maintenance scripts (like daily restart) will not be run.", flush=True)
        elif session_name == TMUX_TARGET_SESSION_NAME:
            print(f"Running in correct tmux session: {session_name}. Extras enabled.", flush=True)
            run_extras = True
        else:
            print(f"ERROR: Expected tmux session '{TMUX_TARGET_SESSION_NAME}', found '{session_name}'. Aborting.", file=sys.stderr, flush=True)
            sys.exit(1)
    else:
        print("SKIP_TMUX is set. Skipping tmux check; extras disabled.", flush=True)

    # Create essential directories in APP_ROOT_DIR
    LOGS_DIR.mkdir(parents=True, exist_ok=True)
    (APP_ROOT_DIR / "mods").mkdir(parents=True, exist_ok=True) # Ensure mods dir exists for prometheus check

    sync_server_files()
    GC_LOG_PATH.unlink(missing_ok=True)

    if run_extras:
        print("Starting daily restart thread.", flush=True)
        threading.Thread(target=daily_restart_task, daemon=True).start()

    web_deploy_script = Path.home() / "web" / "deploy.sh"
    if web_deploy_script.is_file() and web_deploy_script.stat().st_mode & 0o100:
        print(f"Running web deployment script: {web_deploy_script}", flush=True)
        run_command([str(web_deploy_script)], check=False, cwd=Path.home() / "web")

    world_log = LOGS_DIR / "world.log"
    if world_log.exists():
        print(f"Compressing previous world log: {world_log}", flush=True)
        world_log_gz = LOGS_DIR / "world.log.gz"
        try:
            with open(world_log, 'rb') as f_in, open(world_log_gz, 'ab') as f_out:
                subprocess.run(['gzip', '-c'], stdin=f_in, stdout=f_out, check=True)
            world_log.unlink()
            print(f"Compressed log to {world_log_gz}", flush=True)
        except Exception as e:
            print(f"ERROR compressing world log: {e}", file=sys.stderr, flush=True)

    if os.environ.get("KILL_PROMETHEUS") == "1":
        print("KILL_PROMETHEUS is set. Removing Prometheus integration mods...", flush=True)
        for mod_path in (APP_ROOT_DIR / "mods").glob("prometheus-integration-*.jar"):
            print(f"Removing mod: {mod_path}", flush=True)
            mod_path.unlink(missing_ok=True)

    jvm_args_from_file = []
    if USER_JVM_ARGS_FILE.is_file():
        try:
            jvm_args_from_file = USER_JVM_ARGS_FILE.read_text().strip().split()
            print(f"Loaded JVM args from {USER_JVM_ARGS_FILE}: {jvm_args_from_file}", flush=True)
        except Exception as e:
            print(f"Warning: Could not read/parse {USER_JVM_ARGS_FILE}: {e}", file=sys.stderr, flush=True)

    # --- Server Startup Command Construction ---
    java_exec_command = ['java'] # This will be prefixed by `nix shell`
    
    # Determine server type and JRE
    fabric_dir_in_base = BASE_DIR / "fabric"
    fabric_launcher_in_base = fabric_dir_in_base / "fabric-launcher.jar"
    forge_run_script_in_base = BASE_DIR / "forge" / "run.sh"
    cleanroom_jars_in_base = list((BASE_DIR / "forge").glob("cleanroom-*.jar"))

    nix_jre_package = "jre" # Default to latest for modern servers
    server_specific_args = []

    if fabric_dir_in_base.is_dir() and fabric_launcher_in_base.is_file():
        print("Detected Fabric server.", flush=True)
        # nix_jre_package already default
        server_specific_args = ['-jar', str(fabric_launcher_in_base), 'nogui']
    elif forge_run_script_in_base.is_file():
        print("Detected 1.18+ Forge server with run.sh.", flush=True)
        # nix_jre_package already default
        # run.sh handles its own args, including user_jvm_args.txt implicitly.
        # So, we just provide the script to `nix shell ... --command`.
        # The `java_exec_command` will become the path to run.sh.
        java_exec_command = [str(forge_run_script_in_base)]
        jvm_args_from_file = [] # run.sh handles this
    elif cleanroom_jars_in_base:
        selected_cleanroom_jar = sorted(cleanroom_jars_in_base, reverse=True)[0]
        print(f"Detected Cleanroom server: {selected_cleanroom_jar.name}", flush=True)
        # nix_jre_package already default
        server_specific_args = ['-jar', str(selected_cleanroom_jar), 'nogui']
    else:
        print("Detected older Forge server (defaulting to JRE 8).", flush=True)
        nix_jre_package = "jre8"
        forge_jars_in_base = list(BASE_DIR.glob(FORGE_JAR_PATTERN))
        if not forge_jars_in_base:
            print(f"ERROR: No Forge JAR found in {BASE_DIR} matching '{FORGE_JAR_PATTERN}'", file=sys.stderr, flush=True)
            sys.exit(1)
        actual_forge_jar = sorted(forge_jars_in_base, reverse=True)[0]
        print(f"Using Forge JAR: {actual_forge_jar}", flush=True)
        
        base_jvm_args = [
            '-XX:+UnlockExperimentalVMOptions', '-XX:+AggressiveOpts',
            '-XX:+UseG1GC', '-XX:G1HeapRegionSize=32M',
            '-XX:G1NewSizePercent=20', '-XX:+UseAdaptiveGCBoundary'
        ]
        # Prepend base_jvm_args to user-provided ones for this specific case
        jvm_args_from_file = base_jvm_args + jvm_args_from_file
        server_specific_args = ['-jar', str(actual_forge_jar), 'nogui']

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
            # '-p', 'StandardInput=tty', '-p', 'StandardOutput=tty', '-p', 'StandardError=tty', # Ensure TTY if needed
        ] + final_command_to_run

    print(f"Starting server with command: {' '.join(final_command_to_run)}", flush=True)
    print(f"Server CWD: {APP_ROOT_DIR}", flush=True)

    try:
        # Environment for the subprocess - could be useful for nix shell if it needs specific vars
        env = os.environ.copy()
        java_server_process = subprocess.Popen(final_command_to_run, cwd=APP_ROOT_DIR, env=env)
        
        if not using_systemd: # If direct Popen, save its PID
            print(f"Java server process (direct) started with PID: {java_server_process.pid}", flush=True)
            SERVER_JVM_PID_FILE.write_text(str(java_server_process.pid))
        else:
            print(f"systemd-run process started with PID: {java_server_process.pid}. Server runs in scope: {scope_name}", flush=True)

        return_code = java_server_process.wait() # Wait for systemd-run or direct Java to exit

        if using_systemd:
            print(f"systemd-run for {scope_name} exited with code {return_code}.", flush=True)
            # Check scope status for more info if needed: systemctl status scope_name
        else:
            print(f"Java server process {java_server_process.pid if java_server_process else 'N/A'} exited with code {return_code}.", flush=True)

    except FileNotFoundError:
        print(f"ERROR: Could not execute command. Ensure nix, systemd-run (if applicable), or java is available: {final_command_to_run[0]}", file=sys.stderr, flush=True)
        sys.exit(1)
    except Exception as e:
        print(f"ERROR: An unexpected error occurred while starting or managing the server: {e}", file=sys.stderr, flush=True)
        sys.exit(1)
    finally:
        # The atexit handler (cleanup_handler) will run here if the script exits.
        # No need to call cleanup_handler explicitly unless it's a very specific scenario.
        print("Server process has finished. Main script is exiting.", flush=True)

if __name__ == "__main__":
    main()
