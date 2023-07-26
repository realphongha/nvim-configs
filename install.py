import os
import sys
import argparse
import platform
import shutil


def main(opt):
    HOME_PATH = os.path.expanduser("~")
    platf = platform.system()
    if platf in ("Darwin", "Linux"):
        CONFIG_PATH = os.path.join(HOME_PATH, ".config/nvim")
        PACK_PATH = os.path.join(HOME_PATH, ".local/share/nvim/site/pack")
    elif platf == "Windows":
        CONFIG_PATH = os.path.join(HOME_PATH, "AppData/Local/nvim")
        PACK_PATH = os.path.join(HOME_PATH, "AppData/Local/nvim-data/site/pack")
    else:
        raise NotImplementedError(f"Platform {platf} is not supported!")
    if opt.reinstall and not opt.only_configs:
        print("Deleting previous nvim data...")
        try:
            shutil.rmtree(CONFIG_PATH)
            shutil.rmtree(PACK_PATH)
        except OSError as err:
            print(err)
    print(f"Platform detected: {platf if platf != 'Darwin' else 'MacOS'}!")
    os.makedirs(CONFIG_PATH, exist_ok=True)

    print("Writing init.vim...")
    vimrcs = ["vimrcs/basic.vim",]
    if not opt.disable_plugins:
        vimrcs.append("vimrcs/plugins.vim")
    if not opt.disable_nvim_plugins:
        vimrcs.insert(0, "vimrcs/enable_lua.vim")
    if os.path.isfile("vimrcs/my_configs.vim"):
        vimrcs.append("vimrcs/my_configs.vim")
    if opt.extended_plugins:
        vimrcs.append("vimrcs/extended_plugins.vim")
    os.system("cat %s > %s" % (" ".join(vimrcs), os.path.join(CONFIG_PATH, "init.vim")))

    print("Writing .lua files...")
    LUA_CONFIG_PATH = os.path.join(CONFIG_PATH, "lua")
    os.makedirs(LUA_CONFIG_PATH, exist_ok=True)
    lua_files = "luas/basic.lua luas/plugins.lua"
    if opt.extended_plugins:
        lua_files = f"{lua_files} luas/extended_plugins.lua"
    os.system("cat %s > %s" % (lua_files, os.path.join(LUA_CONFIG_PATH, "config.lua")))

    print("Copying colorschemes...")
    COLOR_PATH = os.path.join(CONFIG_PATH, "colors")
    os.makedirs(COLOR_PATH, exist_ok=True)
    COLOR_PACK_PATH = os.path.join(PACK_PATH, "colorschemes/start")
    os.makedirs(COLOR_PACK_PATH, exist_ok=True)
    for name in os.listdir("colorschemes"):
        path = os.path.join("colorschemes", name)
        if os.path.isfile(path) and path.endswith(".vim"):
            shutil.copy(path, COLOR_PATH)
        elif os.path.isdir(path) and not opt.only_configs:
            shutil.copytree(path, os.path.join(COLOR_PACK_PATH, name))
    if opt.only_configs:
        print("Done! Enjoy! :D")
        sys.exit()

    print("Copying plugins...")
    PLUGINS_PATH = os.path.join(PACK_PATH, "basic/start")
    os.makedirs(PLUGINS_PATH, exist_ok=True)
    for dn in os.listdir("plugins"):
        path = os.path.join("plugins", dn)
        if not os.path.isdir(path):
            continue
        shutil.copytree(path, os.path.join(PLUGINS_PATH, dn))

    print("Copying language-wise plugins...")
    LPLUGINS_PATH = os.path.join(PACK_PATH, "languages/start")
    os.makedirs(LPLUGINS_PATH, exist_ok=True)
    for dn in os.listdir("language_plugins"):
        path = os.path.join("language_plugins", dn)
        if not os.path.isdir(path):
            continue
        shutil.copytree(path, os.path.join(LPLUGINS_PATH, dn))

    print("Copying nvim plugins...")
    NVIM_PLUGINS_PATH = os.path.join(PACK_PATH, "nvim/start")
    os.makedirs(NVIM_PLUGINS_PATH, exist_ok=True)
    for dn in os.listdir("nvim_plugins"):
        path = os.path.join("nvim_plugins", dn)
        if not os.path.isdir(path):
            continue
        shutil.copytree(path, os.path.join(NVIM_PLUGINS_PATH, dn))

    if opt.extended_plugins:
        print("Copying extended plugins...")
        EX_PLUGINS_PATH = os.path.join(PACK_PATH, "ex/start")
        os.makedirs(EX_PLUGINS_PATH, exist_ok=True)
        for dn in os.listdir("extended_plugins"):
            path = os.path.join("extended_plugins", dn)
            if not os.path.isdir(path):
                continue
            shutil.copytree(path, os.path.join(EX_PLUGINS_PATH, dn))

    print("Done! Enjoy! :D")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--only-configs',
        action="store_true",
        default=False,
        help="Only install configs"
    )
    parser.add_argument(
        '--disable-plugins',
        action="store_true",
        default=False,
        help="Disable installing plugins"
    )
    parser.add_argument(
        '--disable-nvim-plugins',
        action="store_true",
        default=False,
        help="Disable installing nvim plugins"
    )
    parser.add_argument(
        '--reinstall',
        action="store_true",
        default=False,
        help="Delete config and data directory first"
    )
    parser.add_argument(
        '--extended-plugins',
        action="store_true",
        default=False,
        help="Install extended plugins"
    )
    opt = parser.parse_args()
    main(opt)

