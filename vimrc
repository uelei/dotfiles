
if has('vim_starting')
  set nocompatible               " Be iMproved
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

let neobundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')


if !filereadable(neobundle_readme)
  echo "Installing NeoBundle..."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim/
  let g:not_finsh_neobundle = "yes"
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

"*****************************************************************************
"" NeoBundle install packages
"*****************************************************************************
" NeoBundle 'scrooloose/nerdtree'
" NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-fugitive'
" NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'bling/vim-airline'
" NeoBundle 'airblade/vim-gitgutter'
" NeoBundle 'sheerun/vim-polyglot'
" NeoBundle 'vim-scripts/grep.vim'
" NeoBundle 'vim-scripts/CSApprox'
" NeoBundle 'bronson/vim-trailing-whitespace'
" NeoBundle 'jiangmiao/auto-pairs'
" NeoBundle 'Shougo/vimproc.vim', {
 "      \ 'build' : {
  "     \     'windows' : 'tools\\update-dll-mingw',
   "    \     'cygwin' : 'make -f make_cygwin.mak',
  "     \     'mac' : 'make -f make_mac.mak',
  "     \     'unix' : 'make -f make_unix.mak',
  "     \    },
  "     \ }

"" Vim-Session
" NeoBundle 'xolox/vim-misc'
" NeoBundle 'xolox/vim-session'

"" Snippets
if v:version >= 704
  NeoBundle 'SirVer/ultisnips'
endif

NeoBundle "valloric/youcompleteme" 


NeoBundle "wakatime/vim-wakatime"

"" Python 
NeoBundle "davidhalter/jedi-vim"
" NeoBundle "majutsushi/tagbar"
" NeoBundle "Yggdroot/indentLine"

"" Javascript Bundle
NeoBundle "scrooloose/syntastic"

"" Ruby Bundle
"NeoBundle "tpope/vim-rails"
"NeoBundle "tpope/vim-rake"
"NeoBundle "tpope/vim-projectionist"
"NeoBundle "thoughtbot/vim-rspec"
"NeoBundle "majutsushi/tagbar"
"NeoBundle "ecomba/vim-ruby-refactoring"


"" HTML Bundle
"NeoBundle 'amirh/HTML-AutoCloseTag'
"NeoBundle 'hail2u/vim-css3-syntax'
"NeoBundle 'gorodinskiy/vim-coloresque'
"NeoBundle 'tpope/vim-haml'
"NeoBundle 'mattn/emmet-vim'


"" PHP Bundle
"NeoBundle 'arnaud-lb/vim-php-namespace'



"" Include user's extra bundle
if filereadable(expand("~/.vimrc.local.bundles"))
  source ~/.vimrc.local.bundles
endif

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


colorscheme Tomorrow

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Map leader to ,
"let mapleader=','
"
""" Enable hidden buffers
"set hidden
"
""" Searching
"set hlsearch
"set incsearch
"set ignorecase
"set smartcase
"
""" Encoding
"set bomb
"set binary
"set ttyfast

" Directories for swp files
set nobackup
set noswapfile

"set fileformats=unix,dos,mac
"set showcmd
"set shell=/bin/sh
"
"" session management
"let g:session_directory = "~/.vim/session"
"let g:session_autoload = "no"
"let g:session_autosave = "no"
"let g:session_command_aliases = 1

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number

"let no_buffers_menu=1
"if !exists('g:not_finsh_neobundle')
""  colorscheme molokai
""endif
"
""set mousemodel=popup
""set t_Co=256
""set cursorline
""set guioptions=egmrti
"set gfn=Monospace\ 10
""" Status bar
set laststatus=2
"
""" Use modeline overrides
"set modeline
"set modelines=10
"
"set title
"set titleold="Terminal"
"set titlestring=%F
"
"set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
"

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

""*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"*****************************************************************************
"" Mappings
"*****************************************************************************
" syntastic
" let g:syntastic_always_populate_loc_list=1
" let g:syntastic_error_symbol='✗'
" let g:syntastic_warning_symbol='⚠'
" let g:syntastic_style_error_symbol = '✗'
" let g:syntastic_style_warning_symbol = '⚠'
" let g:syntastic_auto_loc_list=1
" let g:syntastic_aggregate_errors = 1

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

" youcompleteme setup
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string


" ultisnips setup
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file





if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
