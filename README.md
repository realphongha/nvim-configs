# nvim-configs
Reusable configurations for Neovim and auto-install script.  
Tested on nvim 0.9.0, 0.9.1

# How to install  
First clone this repo  
`git clone https://github.com/realphongha/nvim-configs.git`  
`cd nvim-configs`  
get all submodules by  
`git submodule update --init --recursive`
then  
`python3 install.py` to install. See install.py for more options when
installing.  
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

# Acknowledgements
This repo is directly inspired by [vimrc](https://github.com/amix/vimrc).  
## Plugins included:
* [vim-commentary](https://github.com/tpope/vim-commentary)
* [lightline.vim](https://github.com/itchyny/lightline.vim)
* [nerdtree](https://github.com/preservim/nerdtree)
* [vim-gitbranch](https://github.com/itchyny/vim-gitbranch)
* [vim-yankstack](https://github.com/maxbrunsfeld/vim-yankstack)
* [vim-python-pep8-indent](https://github.com/Vimjas/vim-python-pep8-indent)
* [rust.vim](https://github.com/rust-lang/rust.vim)
* [typescript-vim](https://github.com/leafgarland/typescript-vim)
* [vim-javascript](https://github.com/pangloss/vim-javascript)
* [vim-markdown](https://github.com/preservim/vim-markdown)
* [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
* [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
* [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
* [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)
* [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
* [cmp-path](https://github.com/hrsh7th/cmp-path)
* [cmp-vsnip](https://github.com/hrsh7th/cmp-vsnip)
* [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
* [vim-vsnip](https://github.com/hrsh7th/vim-vsnip)
## Colorschemes included:
* [catppuccin](https://github.com/catppuccin/nvim)
* [tokyonight](https://github.com/folke/tokyonight.nvim)
* [gruvbox](https://github.com/morhetz/gruvbox)
* [monokai](https://github.com/sickill/vim-monokai)
* [peaksea](https://github.com/vim-scripts/peaksea)
* [solarized](https://github.com/altercation/vim-colors-solarized)

# PS
Some other useful plugins like the search tool [ack.vim](https://github.com/mileszs/ack.vim), the fuzzy file finder [ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim) or a third-party plugin manager are not included in this project. I'm still using built-in Vim plugins instead :). Feel free to customize them as you like.
