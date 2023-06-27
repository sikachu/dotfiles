" Font
set guifont=Inconsolata\ for\ Powerline:h17.00

" No audible bell
set vb

" No toolbar
set guioptions-=T

" Use console dialogs
set guioptions+=c

" Local config
if filereadable(".gvimrc.local")
  source .gvimrc.local
endif

if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :FzfFiles<CR>
endif

" Use macOS clipboard
" set clipboard=unnamed

" Disable all arrow keys
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>
" imap <up> <nop>
" imap <down> <nop>
" imap <left> <nop>
" imap <right> <nop>
