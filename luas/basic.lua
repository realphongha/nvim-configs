-- INDEX
-- => General
-- => UI
-- => Apperance
-- => Mapping
-- => Autocmd

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
vim.api.nvim_command("filetype plugin on")
vim.api.nvim_command("filetype indent on")

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

-- Colorscheme
vim.cmd.colorscheme("catppuccin-macchiato")

-- Enable 256 colors palette in Gnome Terminal
if os.getenv("COLORTERM") == "gnome-terminal" then
    vim.opt.t_Co = 256
end

-- Use Unix as the standard file type
vim.opt.ffs = "unix,dos,mac"

-- Make background transparent to see your waifu on the terminal
function SeeWaifu(color)
    if color then
        vim.cmd.colorscheme(color)
    end

    -- general
    vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
    vim.api.nvim_set_hl(0, "NormalNC", {bg = "none"})
    -- vim.api.nvim_set_hl(0, "Pmenu", {bg = "none"})
    -- vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
    -- vim.api.nvim_set_hl(0, "FloatShadow", {bg = "none"})

    -- nvim-tree
    vim.api.nvim_set_hl(0, "NvimTreeNormal", {bg = "none"})
    -- vim.api.nvim_set_hl(0, "NvimTreePopup", {bg = "none"})

    -- For telescope.nvim
    vim.api.nvim_set_hl(0, "TelescopeNormal", {bg = "none"})
end

-- }}}

------------------------------------------------------------------------------
-- {{{ => Mapping
-- Set Leader key to Space
vim.g.mapleader = " "

-- Quickly edit vimrc file in the left window pane
vim.api.nvim_set_keymap("n", "<leader>ev", "<c-w>l:e $MYVIMRC<cr>",
    {noremap = true}
)

-- Quickly source vimrc file
vim.api.nvim_set_keymap("n", "<leader>sv", ":source $MYVIMRC<cr>",
    {noremap = true}
)

-- Quickly surround selected text in punctuation marks
vim.api.nvim_set_keymap("v", [[<leader>"]], [[xa""<Esc>P]],
    {noremap = true, silent = true}
)
vim.api.nvim_set_keymap("v", [[<leader>']], [[xa''<Esc>P]],
    {noremap = true, silent = true}
)
vim.api.nvim_set_keymap("v", [[<leader>(]], [[xa()<Esc>P]],
    {noremap = true, silent = true}
)
vim.api.nvim_set_keymap("v", [[<leader>{]], [[xa{}<Esc>P]],
    {noremap = true, silent = true}
)

---- We kept terminal settings in vimscript for more flexibility
-- Quickly exit Terminal mode
-- vim.api.nvim_set_keymap("t", [[<Esc>]], [[<C-\><C-n>]],
--     {noremap = true, silent = true}
-- )

-- Map terminal opening settings
-- if vim.g.os == "Darwin" then
--     vim.cmd([[command Terminal split term://zsh]])
--     vim.cmd([[command TerminalTab tabe term://zsh]])
-- elseif vim.g.os == "Linux" then
--     vim.cmd([[command Terminal split term://bash]])
--     vim.cmd([[command TerminalTab tabe term://bash]])
-- end

-- Quickly open terminal and resize terminal window
-- if vim.g.os == "Windows_NT" then
--     vim.api.nvim_set_keymap("n",
--         [[<leader>T]], [[:split<cr>:resize 10<cr>:term<cr>i]],
--         {noremap = true, silent = true}
--     )
-- else
--     vim.api.nvim_set_keymap("n",
--         [[<leader>T]], [[:Terminal<cr>:resize 10<cr>i]],
--         {noremap = true, silent = true}
--     )
-- end

-- Quickly removes hightlight
vim.api.nvim_set_keymap("", [[<leader><Esc>]], [[:noh<cr>]],
    {noremap = true, silent = true}
)

-- Preserves current yanked after paste
vim.api.nvim_set_keymap("v", [[<leader>p]], [["_dp]],
    {noremap = true, silent = true}
)

-- Quickly moves block up and down
vim.api.nvim_set_keymap("v", "J", [[:m '>+1<CR>gv=gv]],
    {noremap = true, silent = true}
)
vim.api.nvim_set_keymap("v", "K", [[:m '<-2<CR>gv=gv]],
    {noremap = true, silent = true}
)

-- using Ctrl+j, Ctrl+j for navigating in command mode
-- vim.api.nvim_set_keymap("c", "<C-k>", "<up>",
--     {noremap = true, silent = true}
-- )
-- vim.api.nvim_set_keymap("c", "<C-j>", "<down>",
--     {noremap = true, silent = true}
-- )
-- lua doesn't work, I don't have a clue why
vim.cmd([[:cnoremap <C-k> <Up>]])
vim.cmd([[:cnoremap <C-j> <Down>]])

-- Quickly toggle NvimTree
vim.api.nvim_set_keymap("", "<leader>t", ":NvimTreeToggle<cr>",
    {noremap = true, silent = true}
)

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
