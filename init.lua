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

-- import all plugins from "plugins/"
require("lazy").setup("plugins")
-- }}}

------------------------------------------------------------------------------
-- {{{ => General
-- Number of lines in history
vim.opt.history = 500

-- Automatically read file changes
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
    pattern = { "*" },
    command = "silent! checktime",
})

-- Unicode
vim.opt.encoding = "utf-8"

-- No backup
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Use system clipboard
vim.opt.clipboard:append { "unnamed", "unnamedplus" }

-- Disable mouse supporting for faster copying on ssh servers
vim.opt.mouse = ""

-- Tab and indent
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.ai = true   -- Auto indent
vim.opt.si = true   -- Smart indent
vim.opt.wrap = true -- Wrap lines

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

-- Highlight current line number
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Minimum lines to keep above and below the cursor
vim.opt.scrolloff = 5

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
    --     'EndOfBuffer',
    --     "NvimTreeNormal", "NvimTreeNormalNC", "NvimTreePopup", -- nvim-tree
    --     "TelescopeNormal", -- telescope.nvim
    --     'Pmenu', 'NormalFloat', 'FloatShadow',
    -- }
    local hi_groups = {
        'Normal', 'NormalNC',
        "NvimTreeNormal", "NvimTreeNormalNC", -- nvim-tree
        "TelescopeNormal"                     -- telescope.nvim
    }
    if color then
        vim.cmd.colorscheme(color)
    end

    -- general
    for _, hi_group in pairs(hi_groups) do
        vim.api.nvim_set_hl(0, hi_group, { bg = "none" })
    end
end

-- Set colorscheme
SeeWaifu("tokyonight")

-- }}}

------------------------------------------------------------------------------
-- {{{ => Mapping

local wk = require("which-key")

wk.add({
    {
        mode = { "v" },
        { '<leader>"', 'xi""<Esc>P', desc = 'Surround in ""', remap = false },
        { "<leader>'", "xi''<Esc>P", desc = "Surround in ''", remap = false },
        { "<leader>(", "xi()<Esc>P", desc = "Surround in ()", remap = false },
        { "<leader>[", "xi[]<Esc>P", desc = "Surround in []", remap = false },
        { "<leader>{", "xi{}<Esc>P", desc = "Surround in {}", remap = false },
    },
    { "<leader>v",  group = ".vimrc" },
    { "<leader>ve", "<c-w>l:e $MYVIMRC<cr>", desc = "Edit .vimrc", remap = false },
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
wk.add(
    {
        {
            "<leader>T",
            function()
                if vim.g.os == "Windows_NT" then
                    vim.cmd([[:split]])
                    vim.cmd([[:resize 10]])
                    vim.cmd([[:term]])
                else
                    vim.cmd([[:Terminal]])
                    vim.cmd([[:resize 10]])
                end
            end,
            desc = "Open integrated terminal",
            remap = false
        },
        { "<Esc>",         "<C-\\><C-n>",      desc = "Exit terminal mode",              mode = "t",               remap = false },
        { "<leader><Esc>", ":noh<cr>",         desc = "Clear all highlights",            mode = { "n", "o", "v" }, remap = false },
        { "<leader>p",     '"0p',              desc = "Put current yanked register",     mode = { "n", "v" },      remap = false },
        { "<leader>J",     ":m '>+1<CR>gv=gv", desc = "Move selected block down 1 line", mode = "v",               remap = false },
        { "<leader>K",     ":m '<-2<CR>gv=gv", desc = "Move selected block up 1 line",   mode = "v",               remap = false },
    }
)

-- Quickly toggle all other splits and line numbers, useful for copying on
-- remote machines
OnCopyMode = false
function ToggleCopyMode()
    if OnCopyMode then
        vim.cmd(":set number")
        vim.cmd(":set relativenumber")
    else
        vim.cmd(":only")
        vim.cmd(":set nonumber")
        vim.cmd(":set norelativenumber")
    end
    OnCopyMode = not OnCopyMode
end

wk.add({
    { "<leader>cp", ToggleCopyMode, desc = "Toggle copy mode for remote", mode = { "n", "o", "v" }, remap = false },
})

-- lua-style mapping configs doesn't work, don't ask why
vim.cmd([[:cnoremap <C-k> <Up>]])
vim.cmd([[:cnoremap <C-j> <Down>]])
vim.cmd([[:cnoremap <C-h> <Left>]])
vim.cmd([[:cnoremap <C-l> <Right>]])

-- Quickly replace in all quickfixes
function RP(search, replace)
    local command = ":cfdo %s/" .. search .. "/" .. replace .. "/g | update | bd"
    vim.cmd(command)
end

-- Quickly find in all project files using vimgrep
function FP_no_verbose(phrase, path)
    if not path then path = "**" end
    local command = [[:silent vim! /]] .. phrase .. [[/gj ]] .. path
    vim.cmd(command)
end

-- Quickly find in all project files using vimgrep and open the quickfix window
function FP(phrase, path)
    FP_no_verbose(phrase, path)
    vim.cmd([[:copen]])
end

-- Quickly find in all project files using grep and replace all results
function FRP(phrase, replace_phrase, path)
    FP_no_verbose(phrase, path)
    RP(phrase, replace_phrase)
end

-- Buffers
wk.add({
    {
        "<leader>cb",
        function()
            local current_buf = vim.api.nvim_get_current_buf()
            for _, b in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_get_option_value("buflisted", { buf = b }) and b ~= current_buf then
                    vim.api.nvim_buf_delete(b, { force = false })
                end
            end
        end,
        desc = "Delete all buffers except the current one",
        mode = { "n", "o", "v" },
        remap = false
    },
})

-- }}}

------------------------------------------------------------------------------
-- {{{ => Autocmd
vim.api.nvim_create_augroup("common", { clear = true })

-- Cute cat welcomes you each time enter Vim
vim.api.nvim_create_autocmd("VimEnter", {
    group = "common",
    pattern = "*",
    command = [[echo "Hi >^.^<"]]
})

-- Auto save when losing focus
vim.api.nvim_create_autocmd("FocusLost", {
    group = "common",
    pattern = "*",
    nested = true,
    command = [[silent! wall]]
})

-- Auto format JSON files
function JsonFormat()
    vim.cmd([[:execute '%!python -m json.tool']])
end

-- vim.api.nvim_create_autocmd("BufWritePre", {
--     group = "common", pattern = "*.json",
--     callback = JsonFormat
-- })

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
    group = "common",
    pattern = "*.txt,*.js,*.py,*.wiki,*.sh,*.coffee",
    callback = CleanExtraSpaces
})

-- Folding vimscript by marker
vim.api.nvim_create_autocmd("FileType", {
    group = "common",
    pattern = "vim",
    command = [[setlocal foldmethod=marker]]
})

-- Folding lua by marker
vim.api.nvim_create_autocmd("FileType", {
    group = "common",
    pattern = "lua",
    command = [[setlocal foldmethod=marker]]
})

-- New filetypes
vim.api.nvim_create_autocmd("BufRead", {
    group = "common",
    pattern = "*.jpg,*.jpeg,*.png",
    command = [[setfiletype image]]
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
-- {{{ => Include your own configs and plugins
pcall(require, "my_configs")
-- }}}
