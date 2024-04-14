-- INDEX
-- => Lazy.nvim for plugin manager
-- => General
-- => UI
-- => Apperance
-- => Mapping
-- => Autocmd
-- => Misc

------------------------------------------------------------------------------
-- {{{ => Lazy.nvim
--
-- Set Leader key to Space (must be put before Lazy.nvim)
vim.g.mapleader = " "

-- Install Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- import all plugins from "plugins/" directory
require("lazy").setup("plugins")
require("lazy").setup("my_plugins")
-- }}}

------------------------------------------------------------------------------
-- {{{ => General
-- Number of lines in history
vim.opt.history = 500

-- Automatically read file changes
vim.opt.autoread = true
vim.api.nvim_create_autocmd({"FocusGained", "BufEnter"}, {
    pattern = { "*" },
    command = "silent! checktime",
})

-- Unicode
vim.opt.encoding="utf-8"

-- No backup
vim.opt.backup = false
vim.opt.wb = false
vim.opt.swapfile = false

-- Use system clipboard
vim.opt.clipboard:append {"unnamed", "unnamedplus"}

-- Disable mouse supporting for faster copying on ssh servers
vim.opt.mouse = ""

-- Tab and indent
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.ai = true  -- Auto indent
vim.opt.si = true  -- Smart indent
vim.opt.wrap = true  -- Wrap lines

-- Set relative number
vim.opt.relativenumber = true

-- Enable filetype plugins
vim.api.nvim_command("filetype plugin indent on")

-- Use magic for regex
vim.opt.magic = true

-- Show matching brackets when text indicator is over them
vim.opt.showmatch = true

-- Make scrolling and painting fast
-- ttyfast kept for vim compatibility but not needed for nvim
vim.opt.ttyfast = true
vim.opt.lazyredraw = true

-- Split windows to right and below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Detect OS ("Linux", "Darwin" or "Windows_NT")
vim.g.os = vim.loop.os_uname().sysname

-- Get ~ directory path
HOME = os.getenv("HOME")
--}}}

------------------------------------------------------------------------------
-- {{{ => UI
-- Show line numbers
vim.opt.number = true

-- Ruler
vim.opt.textwidth = 79
vim.api.nvim_set_option_value("colorcolumn", "79", {})

-- Highlight search results
vim.opt.hlsearch = true

-- Incremental search
vim.opt.incsearch = true

-- Show current position
vim.opt.ruler = true

-- No annoying error sound
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.cmd("set t_vb=")
vim.opt.tm = 500

-- Always show the status line
vim.opt.laststatus = 2

-- Returns true if paste mode is enabled
-- function HasPaste()
--     if (vim.opt.paste) then
--         return "PASTE MODE  "
--     end
--     return ""
-- end

-- Format the status line
-- vim.cmd([[
-- function! HasPaste()
--     if &paste
--         return 'PASTE MODE  '
--     endif
--     return ''
-- endfunction
-- ]])
-- vim.cmd(
--     [[set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ PATH:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c]]
-- )

-- }}} 

------------------------------------------------------------------------------
-- {{{ => Apperance

-- Syntax highlight
vim.cmd("syntax enable")

-- Background
vim.opt.background = "dark"


-- Enable 256 colors palette in Gnome Terminal
if os.getenv("COLORTERM") == "gnome-terminal" then
    vim.opt.t_Co = 256
end

-- Use Unix as the standard file type
vim.opt.ffs = "unix,dos,mac"

-- Make background transparent to see your waifu on the terminal

function SeeWaifu(color)
    -- local hi_groups = {
    --     'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    --     'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    --     'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    --     'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
    --     'EndOfBuffer', "NvimTreeNormal", "TelescopeNormal"
    --     'Pmenu', 'NormalFloat', 'FloatShadow', "NvimTreePopup"
    -- }
    local hi_groups = {
        'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
        'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
        'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
        'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
        'EndOfBuffer',
        "NvimTreeNormal", "NvimTreeNormalNC", -- nvim-tree
        "TelescopeNormal" -- telescope.nvim
    }
    if color then
        vim.cmd.colorscheme(color)
    end

    -- general
    for _, hi_group in pairs(hi_groups) do
        vim.api.nvim_set_hl(0, hi_group, {bg = "none"})
    end
end

-- Set colorscheme
vim.cmd.colorscheme("catppuccin-macchiato")

-- }}}

------------------------------------------------------------------------------
-- {{{ => Mapping

local wk = require("which-key")

wk.register({
    ["<leader>"] = {
        v = {
            name = ".vimrc",
            e = {
                "<c-w>l:e $MYVIMRC<cr>",
                "Edit .vimrc",
                mode = "n",
                noremap = true,
            },
            s = {
                "<c-w>l:e $MYVIMRC<cr>",
                "Source .vimrc",
                mode = "n",
                noremap = true,
            },
        },
    },
    ["<leader>\""] = {
        [[xa""<Esc>P]],
        [[Surround in ""]],
        mode = "v",
        noremap = true,
        silent = true,
    },
    ["<leader>'"] = {
        [[xa''<Esc>P]],
        [[Surround in '']],
        mode = "v",
        noremap = true,
        silent = true,
    },
    ["<leader>("] = {
        [[xa()<Esc>P]],
        [[Surround in ()]],
        mode = "v",
        noremap = true,
        silent = true,
    },
    ["<leader>{"] = {
        [[xa()<Esc>P]],
        [[Surround in {}]],
        mode = "v",
        noremap = true,
        silent = true,
    },
    ["<leader>["] = {
        [[xa[]<Esc>P]],
        "Surround in []",
        mode = "v",
        noremap = true,
        silent = true,
    },
})

-- Map terminal opening settings
if vim.g.os == "Darwin" then
    vim.cmd([[command Terminal split term://zsh]])
    vim.cmd([[command TerminalTab tabe term://zsh]])
elseif vim.g.os == "Linux" then
    vim.cmd([[command Terminal split term://bash]])
    vim.cmd([[command TerminalTab tabe term://bash]])
end

-- Quickly open terminal and resize terminal window
wk.register({
    ["<Esc>"] = {
        [[<C-\><C-n>]],
        "Exit terminal mode",
        mode = "t",
        noremap = true,
        silent = true,
    },
    ["<leader>"] = {
        T = {
            function ()
                if vim.g.os == "Windows_NT" then
                    vim.cmd([[:split]])
                    vim.cmd([[:resize 10]])
                    vim.cmd([[:term]])
                else
                    vim.cmd([[:Terminal]])
                    vim.cmd([[:resize 10]])
                end
            end,
            "Open integrated terminal",
            mode = "n",
            noremap = true,
            silent = true,
        },
        p = {
            [["0p]],
            "Put current yanked register",
            mode = {"n", "v"},
            noremap = true,
            silent = true,
        },
        J = {
            [[:m '>+1<CR>gv=gv]],
            "Move selected block down 1 line",
            mode = "v",
            noremap = true,
            silent = true,
        },
        K = {
            [[:m '<-2<CR>gv=gv]],
            "Move selected block up 1 line",
            mode = "v",
            noremap = true,
            silent = true,
        },
    },
    ["<leader><Esc>"] = {
        [[:noh<cr>]],
        "Clear all highlights",
        mode = {'n', 'v', 'o'},
        noremap = true,
        silent = true,
    },
})

-- lua-style mapping configs doesn't work, don't ask why
vim.cmd([[:cnoremap <C-k> <Up>]])
vim.cmd([[:cnoremap <C-j> <Down>]])
vim.cmd([[:cnoremap <C-h> <Left>]])
vim.cmd([[:cnoremap <C-l> <Right>]])

-- Quickly replace in all quickfixes
function RP(search, replace)
    local command = ":cdo s/" .. search .. "/" .. replace .. "/g | update"
    vim.cmd(command)
end

-- Quickly find in all project files using grep
function FP(phrase, path, include, exclude)
    if not path then path = "**" end
    local command = [[:silent grep! -r "]] .. phrase .. [[" ]] .. path
    if include then
        command = command .. " --include " .. include
    end
    if exclude then
        command = command .. " --exclude" .. exclude
    end

    vim.cmd(command)
    print("Done searching! :copen to see the results!")
end

-- Quickly find in all project files using grep and replace all results
function FRP(phrase, replace_phrase, path, include, exclude)
    FP(phrase, path, include, exclude)
    RP(phrase, replace_phrase)
end

-- }}}

------------------------------------------------------------------------------
-- {{{ => Autocmd
vim.api.nvim_create_augroup("common", {clear = true})

-- Cute cat welcomes you each time enter Vim
vim.api.nvim_create_autocmd("VimEnter", {
    group = "common", pattern = "*",
    command = [[echo "Hi >^.^<"]]
})

-- Auto save when losing focus
vim.api.nvim_create_autocmd("FocusLost", {
    group = "common", pattern = "*", nested = true,
    command = [[silent! wall]]
})

-- Auto format JSON files
vim.api.nvim_create_autocmd("BufWritePre", {
    group = "common", pattern = "*.json",
    command = [[:execute '%!python -m json.tool' | w]]
})

-- Delete trailing white space on save, useful for some filetypes ;)
function CleanExtraSpaces()
    local save_cursor = vim.fn.getpos(".")
    -- local old_query = vim.fn.getpos(".")
    vim.cmd([[silent! %s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
    -- vim.fn.setreg("/", old_query)
end


-- Auto delete trailing spaces
vim.api.nvim_create_autocmd("BufWritePre", {
    group = "common", pattern = "*.txt,*.js,*.py,*.wiki,*.sh,*.coffee",
    callback = CleanExtraSpaces
})

-- Folding vimscript by marker
vim.api.nvim_create_autocmd("FileType", {
    group = "common", pattern = "vim",
    command = [[setlocal foldmethod=marker]]
})

-- Folding lua by marker
vim.api.nvim_create_autocmd("FileType", {
    group = "common", pattern = "lua",
    command = [[setlocal foldmethod=marker]]
})

-- }}}

------------------------------------------------------------------------------
-- {{{ => Misc
-- netrw
------------------------------------------------------------------------------
vim.cmd([[
" Disables netrw by default
let g:loaded_netrw=1
let g:loaded_netrwPlugin=1

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split=4
let g:netrw_altv=1

" Default to tree mode
let g:netrw_liststyle=3

" Keep the current directory and the browsing directory synced
let g:netrw_keepdir=0

" Window size
let g:netrw_winsize=20

" Hide banner
let g:netrw_banner=0

" Enable recursive copy
let g:netrw_localcopydircmd='cp -r'

" Sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'

" Highlight marked files
hi! link netrwMarkFile Search
]])

-- the silver searcher
vim.cmd([[
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
]])
-- }}}

------------------------------------------------------------------------------
-- {{{ => Include your own configs 
pcall(require, "my_plugins")
-- }}}
