import re
import sys
import subprocess
from termios import tcgetattr, ECHO, ICANON, ISIG


def main(args):
    """
    If run directly, reads the last line of stdin if stdin is not a TTY.
    """
    if not sys.stdin.isatty():
        return sys.stdin.read().strip().split("\n")[-1]
    else:
        print("\a")
        print("Tried to read a tty")


def handle_result(args, data, target_window_id, boss):
    """
    Detects password prompts based on terminal modes and prompt text,
    then securely pastes the password obtained via subprocess.

    Args:
        args: List[str] - First arg is script name, args[1:] is the command to get password.
        data: str - Output from the terminal.
        target_window_id: str - ID of the window to interact with.
        boss: Kitty "boss" object, provides access to window map.
    """
    window = boss.window_id_map.get(target_window_id)
    if window is None:
        return

    c_lflag = tcgetattr(window.child.child_fd)[3]

    def is_flag_set(flag):
        return bool(c_lflag & flag)

    def get_password_prompt_type(text):
        if re.match(r"^Password.*:", text):
            return "kitty"
        elif re.match(r".* passphrase.* for .*/id_ed25519.*", text):
            return "passphrase"
        else:
            return

    def send_password(keychain_item_name="kitty"):
        password = subprocess.run(
            ["security", "find-generic-password", "-a", keychain_item_name, "-w"],
            capture_output=True,
            text=True,
            check=True,
        ).stdout.strip()
        window.paste_bytes(f"{password}\r")

    keychain_item_name = get_password_prompt_type(data)

    # Detect classic sudo-style hidden prompt
    if is_flag_set(ISIG) and is_flag_set(ICANON) and not is_flag_set(ECHO):
        send_password("kitty")

    # Detect raw terminal prompt with known patterns (e.g., ssh, gpg, kinit)
    elif (
        not is_flag_set(ISIG)
        and not is_flag_set(ICANON)
        and not is_flag_set(ECHO)
        and keychain_item_name
    ):
        send_password(keychain_item_name)

    else:
        print("\a")
        print("Ooops. Are you at a password prompt?")


handle_result.type_of_input = "text"

if __name__ == "__main__":
    main(sys.argv)
