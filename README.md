# nvim-configs
Reusable configurations for Neovim and auto-install script.  
Tested on nvim 0.9.0

# How to install  
First clone this repo  
`git clone https://github.com/realphongha/nvim-configs.git`  
`cd nvim-configs`  
get all submodules by  
`git submodule update --init --recursive`
then  
`python3 install.py` to install.  
You can now `rm -rf nvim-configs` to save disk space.  
For reinstalling, ~/.config/nvim and ~/.local/share/nvim or ~/AppData/Local/nvim
for Windows must be deleted first. You can also do that with --reinstall flag:  
`python3 install.py --reinstall`

# Install LSP servers:
## For pyright:
`npm i -g pyright`  
pyright configs are already on config.lua.

# Add customized configs
Create vimrcs/my_configs.vim or luas/my_configs.lua and customize your own configs.
Then install it with the same commands above.
