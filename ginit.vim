" Enable Mouse
set mouse=nvi

if exists("g:neovide")
    set guifont=JetBrainsMono\ Nerd\ Font:h12
    set linespace=0
    let g:neovide_scale_factor = 1.0
    let g:neovide_padding_top = 5
    let g:neovide_padding_bottom = 5
    let g:neovide_padding_right = 5
    let g:neovide_padding_left = 5
    "let g:neovide_window_blurred = v:true
    "let g:neovide_floating_blur_amount_x = 2.0
    "let g:neovide_floating_blur_amount_y = 2.0
    "let g:neovide_transparency = 0.8
    let g:neovide_show_border = v:true
endif

" Detect OS
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows_NT"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" For NeovimQT
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
if exists(':GuiShowContextMenu')
    nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
    inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
    xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
    snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
endif

if !exists("g:neovide") " Neovide configs is loaded first somehow
    " Exclusive colorscheme configs for GUI Neovim
    colorscheme catppuccin

    if (g:os != "Windows_NT")
        NvimTreeClose
    endif
endif
