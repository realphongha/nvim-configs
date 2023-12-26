import os
import sys
import argparse
import platform
import shutil


def main(opt):
    HOME_PATH = os.path.expanduser("~")
    platf = platform.system()
    print(f"Platform detected: {platf if platf != 'Darwin' else 'MacOS'}!")
    if platf in ("Darwin", "Linux"):
        CONFIG_PATH = os.path.join(HOME_PATH, ".config/nvim")
        DATA_PATH = os.path.join(HOME_PATH, ".local/share/nvim/")
    elif platf == "Windows":
        CONFIG_PATH = os.path.join(HOME_PATH, "AppData/Local/nvim")
        DATA_PATH = os.path.join(HOME_PATH, "AppData/Local/nvim-data/")
    else:
        raise NotImplementedError(f"Platform {platf} is not supported!")

    print("Deleting previous configs...")
    try:
        ans = input(f"Your `{CONFIG_PATH}` directory will be deleted!"
            " Continue? (y/n): ")
        ans = ans.strip().lower()
        if ans != "y":
            sys.exit(0)
        shutil.rmtree(CONFIG_PATH)
        if opt.reinstall:
            print("Deleting neovim data...")
            ans = input(f"Your `{DATA_PATH}` directory will be deleted!"
                " Continue? (y/n): ")
            ans = ans.strip().lower()
            if ans != "y":
                sys.exit(0)
            shutil.rmtree(DATA_PATH)
    except OSError as err:
        print(err)
    os.makedirs(CONFIG_PATH, exist_ok=True)
    PLUGINS_PATH = os.path.join(CONFIG_PATH, "lua", "plugins")
    os.makedirs(PLUGINS_PATH, exist_ok=True)

    print("Writing new configs...")
    print("init.lua")
    lua_files = "vimrcs/init.lua"
    if os.path.isfile("vimrcs/my_configs.lua"):
        lua_files += " vimrcs/my_configs.lua"
    os.system("cat %s > %s" % (lua_files, os.path.join(CONFIG_PATH, "init.lua")))
    print("ginit.vim")
    shutil.copy("vimrcs/ginit.vim", CONFIG_PATH)
    print("Plugins...")
    for fn in os.listdir("plugins"):
        if fn.endswith(".lua"):
            shutil.copy(os.path.join("plugins", fn), PLUGINS_PATH)
    for fn in os.listdir("my_plugins"):
        if fn.endswith(".lua"):
            shutil.copy(os.path.join("my_plugins", fn), PLUGINS_PATH)

    print("Done! Enjoy! :D")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--reinstall',
        action="store_true",
        default=False,
        help="Reset all neovim data first"
    )
    opt = parser.parse_args()
    main(opt)

