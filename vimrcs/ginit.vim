" Enable Mouse
set mouse=a

" Detect OS
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows_NT"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    if (g:os == "Windows_NT")
        GuiFont! JetBrainsMono Nerd Font:h10.5
    else
        GuiFont! JetBrainsMono Nerd Font:h14
    endif
endif

" Disable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 0
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif

" Enable GUI ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 1
endif

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv

" Exclusive colorscheme configs for Neovim Qt
colorscheme catppuccin

if (g:os != "Windows_NT")
    NvimTreeClose
endif
