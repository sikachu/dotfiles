" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Use old RegExp engine
set re=0

" Vundle
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'dense-analysis/ale'
Plugin 'fatih/vim-go'
Plugin 'gmarik/Vundle.vim'
Plugin 'godlygeek/tabular'
Plugin 'google/vim-jsonnet'
Plugin 'groenewege/vim-less'
Plugin 'hashivim/vim-terraform'
Plugin 'janko-m/vim-test'
Plugin 'kchmck/vim-coffee-script'
Plugin 'koron/nyancat-vim'
Plugin 'mileszs/ack.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'othree/html5.vim'
Plugin 'pbrisbin/vim-mkdir'
Plugin 'sikachu/vim-liquid'
Plugin 'skwp/greplace.vim'
Plugin 'slim-template/vim-slim'
Plugin 'towolf/vim-helm'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vividchalk'
Plugin 'udalov/kotlin-vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-scripts/tComment'
Plugin 'wsdjeg/vim-fetch'

" fzf
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup
set nowritebackup
set history=50    " keep 50 lines of command line history
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching

" au WinLeave * set nocursorline
" au WinEnter * set cursorline
" set cursorline

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END
else
  set autoindent    " always set autoindenting on
endif " has("autocmd")

if has("folding")
  set foldenable
  set foldmethod=syntax
  set foldlevelstart=50
  " set foldlevel=1
  " set foldnestmax=2
  " set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '
endif

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Always display the status line
set laststatus=2

" \ is the leader character
let mapleader = "\\"

" Edit the README_FOR_APP (makes :R commands work)
map <Leader>R :e doc/README_FOR_APP<CR>

" Leader shortcuts for Rails commands
map <Leader>m :Rmodel
map <Leader>c :Rcontroller
map <Leader>v :Rview
map <Leader>u :Runittest
map <Leader>f :Rfunctionaltest
map <Leader>tm :RTmodel
map <Leader>tc :RTcontroller
map <Leader>tv :RTview
map <Leader>tu :RTunittest
map <Leader>tf :RTfunctionaltest
map <Leader>sm :RSmodel
map <Leader>sc :RScontroller
map <Leader>sv :RSview
map <Leader>su :RSunittest
map <Leader>sf :RSfunctionaltest

" Turn off search highlight
map <Leader>h :nohlsearch <CR>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
"
" Inserts file name of the currently edited file into a command
" Command mode: Ctrl+O
cmap <C-O> <C-R>=expand("%:t") <CR>

" Maps autocomplete to tab
imap <Tab> <C-N>

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" No Help, please
nmap <F1> <Esc>

" Press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Edit routes
command! Eroutes :e config/routes.rb
command! Troutes :tabe config/routes.rb
command! Eschema :e db/schema.rb
command! Tschema :tabe db/schema.rb

" Load local config if available
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" Use Ag instead of Grep when available
if executable("ag")
  set grepprg=ag
  let g:grep_cmd_opts = '--line-numbers --noheading --nobreak'
  let g:ackprg = 'ag --vimgrep'
endif

" Color scheme
colorscheme vividchalk
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0
highlight diffRemoved guifg=#CC0000

" Numbers
" NOTE: This is disabled due to performance problem in MacVim
" if v:version > 702
"   set relativenumber
"
"   " http://stackoverflow.com/questions/762515/vim-remap-key-to-toggle-line-numbering
"   " source: http://stackoverflow.com/questions/4387210/vim-how-to-map-two-tasks-under-one-shortcut-key
"   let g:relativenumber = 0
"   set nonumber
"   set relativenumber
"   function! ToggleRelativeNumber()
"     if g:relativenumber == 0
"       let g:relativenumber = 1
"       set number
"       set norelativenumber
"     else
"       let g:relativenumber = 0
"       set nonumber
"       set relativenumber
"     endif
"   endfunction
"   map <C-L> :call ToggleRelativeNumber()<cr>
" else
"   set number
" endif
" set numberwidth=5
set number

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu
set wildmode=list:longest,list:full
set complete=.,t

" case only matters with mixed case expressions
set ignorecase
set infercase
set smartcase

" disable mouse
set mouse-=a

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Add function for remove tailing whitespaces
command! CleanupTrailingSpaces :%s/\s\+$//ge | :nohlsearch
" autocmd InsertLeave * :CleanupTrailingSpaces

" Override the line for git commit message
au FileType gitcommit set colorcolumn=51,73
au FileType gitcommit setlocal spell

" Show lines at various widths
set colorcolumn=81,101,121
highlight ColorColumn ctermbg=0 guibg=#333333

" Split on the right
let g:netrw_altv = 1
let g:netrw_winsize = 80

" Stupid command alias
cabbrev vps vsp

" ack/ag alias
cabbrev Ag Ack

" Redraw the editor
map <Leader>r :redraw!<cr>

" Next in quickfix list
map <Leader>n :cn<cr>
nmap <Leader>n :cn<cr>

" Custom file type
autocmd BufNewFile,BufRead Appraisals set filetype=ruby
autocmd BufNewFile,BufRead Gemfile set filetype=ruby
autocmd BufNewFile,BufRead *.rabl set filetype=ruby
autocmd BufNewFile,BufRead Dangerfile set filetype=ruby

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
let test#strategy = "terminal"
let test#ruby#bundle_exec = 0
let g:test#preserve_screen = 1

" Setup for Powerline
set pythonthreedll=/opt/homebrew/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/Python
set pythonthreehome=/opt/homebrew/opt/python@3.9/Frameworks/Python.framework/Versions/3.9
let g:rails_statusline = 0
py3 from powerline.vim import setup as powerline_setup
py3 powerline_setup()
py3 del powerline_setup
set shell=/bin/sh

" Keep 3 lines below and above the cursor
set scrolloff=5

" Ruby default for c file
autocmd FileType c setlocal shiftwidth=4 softtabstop=4 tabstop=8 expandtab

" let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|tmp'
" let g:ctrlp_max_files = 0
" let g:ctrlp_max_depth = 40

" ALE related
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 0
" let g:ale_ruby_rubocop_executable = 'rubocop-daemon-wrapper'
let g:ale_linters_ignore = { 'ruby': ['brakeman'] }
au BufRead,BufNewFile */.github/*/*.y{,a}ml
  \ let b:ale_linters = {'yaml': ['actionlint']}
let g:ale_fixers = {'ruby': ['rubocop']}
let g:ale_fix_on_save = 1
command! ALEToggleFixer execute "let g:ale_fix_on_save = get(g:, 'ale_fix_on_save', 0) ? 0 : 1"

" fzf related
let g:fzf_layout = { 'down': '40%' }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_command_prefix = 'Fzf'

" Terraform
let g:terraform_align = 1
let g:terraform_fmt_on_save = 1