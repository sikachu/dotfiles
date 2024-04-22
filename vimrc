" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Use old RegExp engine
" setting re=1 prevents Ruby syntax highlighting to slow down
set re=1

" Vundle
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'andymass/vim-matchup'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'dense-analysis/ale'
Plugin 'fatih/vim-go'
Plugin 'godlygeek/tabular'
Plugin 'google/vim-jsonnet'
Plugin 'groenewege/vim-less'
Plugin 'hashivim/vim-terraform'
Plugin 'kchmck/vim-coffee-script'
Plugin 'koron/nyancat-vim'
Plugin 'mileszs/ack.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'othree/html5.vim'
Plugin 'pbrisbin/vim-mkdir'
Plugin 'posva/vim-vue'
Plugin 'sikachu/vim-liquid'
Plugin 'sikachu/vim-test'
Plugin 'skwp/greplace.vim'
Plugin 'slim-template/vim-slim'
Plugin 'towolf/vim-helm'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-dispatch'
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
Plugin 'yssl/QFEnter'

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

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

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

" Use space bar and backslash as leader keys
let mapleader = "\\"
noremap <SPACE> <Nop>
map <Space> <Leader>

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

" No Help, please
nmap <F1> <Esc>

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

" Enable line number
set numberwidth=5
set number relativenumber

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options
" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu
set wildmode=list:longest,list:full
set complete=.,t

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Add function for remove tailing whitespaces
command! CleanupTrailingSpaces :%s/\s\+$//ge | :nohlsearch

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

" Don't jump to the first result automatically
cnoreabbrev Ack Ack!

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
let test#strategy = "dispatch"
let test#ruby#bundle_exec = 0

" Setup for Powerline
set pythonthreedll=/opt/homebrew/opt/python/Frameworks/Python.framework/Versions/Current/Python
set pythonthreehome=/opt/homebrew/opt/python/Frameworks/Python.framework/Versions/Current
let g:rails_statusline = 0
" Use powerline from venv and add to PATH
" $ python3 -m venv ~/.vim/powerline-status
" $ ~/.vim/powerline-status/bin/pip3 install powerline-status
py3 import sys,os; sys.path.append(os.path.expanduser("~/.vim/powerline-status/lib/python3.12/site-packages/"))
py3 from powerline.vim import setup as powerline_setup
py3 powerline_setup()
py3 del powerline_setup
set shell=/bin/sh

" Keep 3 lines below and above the cursor
set scrolloff=5

" Ruby default for c file
autocmd FileType c setlocal shiftwidth=4 softtabstop=4 tabstop=8 expandtab

" ALE related
let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_insert_leave = 0
" let g:ale_ruby_rubocop_executable = 'rubocop-daemon-wrapper'
let g:ale_virtualtext_cursor = 'disabled'
let g:ale_linters_ignore = { 'ruby': ['brakeman'] }
let g:ale_linters = {'ruby': ['rubocop', 'ruby']}
au BufRead,BufNewFile */.github/*/*.y{,a}ml
  \ let b:ale_linters = {'yaml': ['actionlint']}
let g:ale_fixers = {'ruby': ['rubocop'], 'vue': ['prettier']}
let g:ale_fix_on_save = 1
command! ALEToggleFixer execute "let g:ale_fix_on_save = get(g:, 'ale_fix_on_save', 0) ? 0 : 1"

" fzf related
let g:fzf_layout = { 'down': '40%' }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_command_prefix = 'Fzf'

" Override vim-ruby indentation rule for assignment style indentation
" See :help vim-ruby-indent
let g:ruby_indent_assignment_style = 'variable'
let g:ruby_indent_hanging_elements = 1

" Terraform
let g:terraform_align = 1
let g:terraform_fmt_on_save = 1

" Vue
let g:vue_pre_processors = ['scss']

" QFEnter
let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']

" Easy add binding.irb above/below current line
map <Leader>I :normal Obinding.irb<ESC>
map <Leader>i :normal obinding.irb<ESC>
