# nvim-configs
Reusable configurations for Neovim and auto-install script.

# How to install  
`cd nvim-configs`  
get all submodules by  
`git submodule update --init --recursive`
then  
`python3 install.py` to install.  
You can now `rm -rf nvim-configs` to save disk space.  
For reinstalling, ~/.config/nvim and ~/.local/share/nvim (~/AppData/Local/nvim for Windows) must be deleted first.


# Add customized configs
Create vimrcs/my_configs.vim or luas/my_configs.lua and customize your own configs.
Then install it with the same commands above.
