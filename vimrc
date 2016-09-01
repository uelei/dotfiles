"*****************************************************************************
" NeoBundle core
"*****************************************************************************
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

let neobundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')

if !filereadable(neobundle_readme)
  echo "Installing NeoBundle..."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim/
  let g:not_finsh_neobundle = "yes"

  " Run shell script if exist on custom select language
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

"*****************************************************************************
"" NeoBundle install packages
"*****************************************************************************

" install youcompleteme and compile
NeoBundle 'Valloric/YouCompleteMe', {
     \ 'build'      : {
        \ 'mac'     : './install.py',
        \ 'unix'    : './install.py',
        \ 'windows' : 'install.py',
        \ 'cygwin'  : './install.py'
        \ }
     \ }

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-fugitive'

" Wakatime
NeoBundle 'wakatime/vim-wakatime'

NeoBundle 'ervandew/supertab'

if v:version >= 704
  "" Snippets
  NeoBundle 'SirVer/ultisnips'
  NeoBundle 'FelikZ/ctrlp-py-matcher'
endif
NeoBundle 'honza/vim-snippets'

NeoBundle 'xolox/vim-notes'
NeoBundle 'xolox/vim-misc'

NeoBundle 'itchyny/lightline.vim'
NeoBundle 'shirataki/lightline-onedark'

NeoBundle 'terryma/vim-multiple-cursors'

" Color
NeoBundle 'joshdick/onedark.vim'
" NeoBundle 'dracula/vim'

NeoBundle 'sheerun/vim-polyglot'

"Go
NeoBundle 'fatih/vim-go'

"Tests
NeoBundle 'janko-m/vim-test'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
" set history=500

" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
" command W w !sudo tee % > /dev/null

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

"Always show current position
set ruler

set number 

" Ignore case when searching
set ignorecase
 
" When searching try to be smart about cases 
set smartcase
 
" Highlight search results
set hlsearch
 
" Makes search act like search in modern browsers
set incsearch 
 
" Don't redraw while executing macros (good performance config)
set lazyredraw 
 
" For regular expressions turn magic on
set magic
 
"" Show matching brackets when text indicator is over them
set showmatch 
 
" set cmdheight=2
" Show key pressed
set showcmd
 
"" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

set foldmethod=indent
set foldlevel=10

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 
 
"" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf-8
scriptencoding utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac
 
" highlight ColorColumn ctermbg=gray
set colorcolumn=80

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
 
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


"""""""""""""""""""""""""""""""
"" => Visual mode related
"""""""""""""""""""""""""""""""
"" Visual mode pressing * or # searches for the current selection
"" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
 
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Moving around, tabs, windows and buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Treat long lines as break lines (useful when moving around in them)
"map j gj
"map k gk
 
"" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
"" map <space> /
"" map <c-space> ?
 
"" Disable highlight when <leader><cr> is pressed
"map <silent> <leader><cr> :noh<cr>
 
"" Smart way to move between windows
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l
 
"" Close the current buffer
"map <leader>bd :Bclose<cr>:tabclose<cr>gT
 
"" Close all the buffers
"map <leader>ba :bufdo bd<cr>
 
"map <leader>l :bnext<cr>
"map <leader>h :bprevious<cr>
 
"" Useful mappings for managing tabs
"map <leader>tn :tabnew<cr>
"map <leader>to :tabonly<cr>
"map <leader>tc :tabclose<cr>
"map <leader>tm :tabmove 
"map <leader>t<leader> :tabnext 
 
"" Let 'tl' toggle between this and the last accessed tab
"" let g:lasttab = 1
"" nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
"" au TabLeave * let g:lasttab = tabpagenr()
 
 
"" Opens a new tab with the current buffer's path
"" Super useful when editing files in the same directory
"" map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
 
"" Switch CWD to the directory of the open buffer
"" map <leader>cd :cd %:p:h<cr>:pwd<cr>
 
"" Specify the behavior when switching between buffers 
"" try
""   set switchbuf=useopen,usetab,newtab
""   set stal=2
"" catch
"" endtry

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Editing mappings
"" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" " Remap VIM 0 to first non-blank character
"" map 0 ^
 
"" " Move a line of text using ALT+[jk] or Command+[jk] on mac
"" nmap <M-j> mz:m+<cr>`z
"" nmap <M-k> mz:m-2<cr>`z
"" vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
"" vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
 
"" if has("mac") || has("macunix")
""   nmap <D-j> <M-j>
""   nmap <D-k> <M-k>
""   vmap <D-j> <M-j>
""   vmap <D-k> <M-k>
"" endif
 
"" " Delete trailing white space on save, useful for Python and CoffeeScript ;)
"" func! DeleteTrailingWS()
""   exe "normal mz"
""   %s/\s\+$//ge
""   exe "normal `z"
"" endfunc
"" autocmd BufWrite *.py :call DeleteTrailingWS()
"" autocmd BufWrite *.coffee :call DeleteTrailingWS()
 
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Ag searching and cope displaying
""    requires ag.vim - it's much better than vimgrep/grep
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" When you press gv you Ag after the selected text
"" vnoremap <silent> gv :call VisualSelection('gv', '')<CR>
 
"" Open Ag and put the cursor in the right position
"" map <leader>g :Ag 
 
"" When you press <leader>r you can search and replace the selected text
"" vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>
 
"" Do :help cope if you are unsure what cope is. It's super useful!
""
"" When you search with Ag, display your results in cope by doing:
""   <leader>cc
""
"" To go to the next search result do:
""   <leader>n
""
"" To go to the previous search results do:
""   <leader>p
""
"" map <leader>cc :botright cope<cr>
"" map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
"" map <leader>n :cn<cr>
"" map <leader>p :cp<cr>
 
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Spell checking
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Pressing ,ss will toggle and untoggle spell checking
"" map <leader>ss :setlocal spell!<cr>
 
"" Shortcuts using <leader>
"" map <leader>sn ]s
"" map <leader>sp [s
"" map <leader>sa zg
"" map <leader>s? z=
 
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Misc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Remove the Windows ^M - when the encodings gets messed up
"" noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
 
"" Quickly open a buffer for scribble
"" map <leader>q :e ~/buffer<cr>
 
"" Quickly open a markdown buffer for scribble
"" map <leader>x :e ~/buffer.md<cr>
 
"" Toggle paste mode on and off
"" map <leader>pp :setlocal paste!<cr>
 
 
 
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Helper functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" function! CmdLine(str)
""     exe "menu Foo.Bar :" . a:str
""     emenu Foo.Bar
""     unmenu Foo
"" endfunction 
 
"" function! VisualSelection(direction, extra_filter) range
""     let l:saved_reg = @"
""     execute "normal! vgvy"
 
""     let l:pattern = escape(@", '\\/.*$^~[]')
""     let l:pattern = substitute(l:pattern, "\n$", "", "")
 
""     if a:direction == 'gv'
""         call CmdLine("Ag \"" . l:pattern . "\" " )
""     elseif a:direction == 'replace'
""         call CmdLine("%s" . '/'. l:pattern . '/')
""     endif
 
""     let @/ = l:pattern
""     let @" = l:saved_reg
"" endfunction
 
 
"" " Returns true if paste mode is enabled
"" function! HasPaste()
""     if &paste
""         return 'PASTE MODE  '
""     endif
""     return ''
"" endfunction
 
"" " Don't close window, when deleting a buffer
"" command! Bclose call <SID>BufcloseCloseIt()
"" function! <SID>BufcloseCloseIt()
""    let l:currentBufNum = bufnr("%")
""    let l:alternateBufNum = bufnr("#")
 
""    if buflisted(l:alternateBufNum)
""      buffer #
""    else
""      bnext
""    endif
 
""    if bufnr("%") == l:currentBufNum
""      new
""    endif
 
""    if buflisted(l:currentBufNum)
""      execute("bdelete! ".l:currentBufNum)
""    endif
"" endfunction
 
"" Make VIM remember position in file after reopen
"" if has("autocmd")
""   au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
""
""endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GUI related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set font according to system
if has("mac") || has("macunix")
    set gfn=Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
elseif has("win16") || has("win32")
    set gfn=Hack:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
    set gfn=Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("linux")
    set gfn=Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
    set gfn=Monospace\ 11
endif
 
"" Open MacVim in fullscreen mode
"" if has("gui_macvim")
""     set fuoptions=maxvert,maxhorz
""     " au GUIEnter * set fullscreen
"" endif
 
"" Disable scrollbars (real hackers don't use scrollbars for navigation!)
"" set guioptions-=r
"" set guioptions-=R
"" set guioptions-=l
"" set guioptions-=L
 
"" Colorscheme
"set background=dark
 
try
    " colorscheme peaksea
    " color dracula
    " color atom-dark
    colorscheme onedark
    "colorscheme base16-default-dark
    " colorscheme desert
catch
endtry
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Fast editing and reloading of vimrc configs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" map <leader>e :e! ~/.vim_runtime/my_configs.vim<cr>
"" autocmd! bufwritepost vimrc source ~/.vim_runtime/my_configs.vim
 
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Turn persistent undo on 
""    means that you can undo even when you close a buffer/VIM
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" try
""     set undodir=~/.vim_runtime/temp_dirs/undodir
""     set undofile
"" catch
"" endtry
 
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Command mode related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Smart mappings on the command line
"" cno $h e ~/
"" cno $d e ~/Desktop/
"" cno $j e ./
"" cno $c e <C-\>eCurrentFileDir("e")<cr>
 
"" $q is super useful when browsing on the command line
"" it deletes everything until the last slash 
"" cno $q <C-\>eDeleteTillSlash()<cr>
 
"" Bash like keys for the command line
"" cnoremap <C-A>		<Home>
"" cnoremap <C-E>		<End>
"" cnoremap <C-K>		<C-U>
 
"" cnoremap <C-P> <Up>
"" cnoremap <C-N> <Down>
 
"" Map ½ to something useful
"" map ½ $
"" cmap ½ $
"" imap ½ $
 
" cnoreabbrev W! w!
cnoreabbrev Q! q!
"cnoreabbrev Qall! qall!
"cnoreabbrev Wq wq
"cnoreabbrev Wa wa
"cnoreabbrev wQ wq
"cnoreabbrev WQ wq
"cnoreabbrev W w
"cnoreabbrev Q q
"cnoreabbrev Qall qall
 
 
"" nnoremap <Tab> gt
"" nnoremap <S-Tab> gT
"" nnoremap <silent> <S-t> :tabnew<CR>
 
""" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

""" Move visual block
"vnoremap J :m '>+1<CR>gv=gv
"vnoremap K :m '<-2<CR>gv=gv
 
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Parenthesis/bracket
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vnoremap $1 <esc>`>a)<esc>`<i(<esc>
"" vnoremap $2 <esc>`>a]<esc>`<i[<esc>
"" vnoremap $3 <esc>`>a}<esc>`<i{<esc>
"" vnoremap $$ <esc>`>a"<esc>`<i"<esc>
"" vnoremap $q <esc>`>a'<esc>`<i'<esc>
"" vnoremap $e <esc>`>a"<esc>`<i"<esc>
 
"" " Map auto complete of (, ", ', [
"" inoremap $1 ()<esc>i
"" inoremap $2 []<esc>i
"" inoremap $3 {}<esc>i
"" inoremap $4 {<esc>o}<esc>O
"" inoremap $q ''<esc>i
"" inoremap $e ""<esc>i
 
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => General abbreviations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
 
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Omni complete functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" autocmd FileType css set omnifunc=csscomplete#CompleteCSS
 
 
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Helper functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" func! DeleteTillSlash()
""     let g:cmd = getcmdline()
 
""     if has("win16") || has("win32")
""         let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
""     else
""         let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
""     endif
 
""     if g:cmd == g:cmd_edited
""         if has("win16") || has("win32")
""             let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
""         else
""             let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
""         endif
""     endif   
 
""     return g:cmd_edited
"" endfunc
 
"" func! CurrentFileDir(cmd)
""     return a:cmd . " " . expand("%:p:h") . "/"
"" endfunc
 
"" """"""""""""""""""""""""""""""
"" " => Python section
"" """"""""""""""""""""""""""""""
"" let python_highlight_all = 1
"" au FileType python syn keyword pythonDecorator True None False self
 
"" au BufNewFile,BufRead *.jinja set syntax=htmljinja
"" au BufNewFile,BufRead *.mako set ft=mako
 
"" au FileType python inoremap <buffer> $r return 
"" au FileType python inoremap <buffer> $i import 
"" au FileType python inoremap <buffer> $p print 
"" au FileType python inoremap <buffer> $f #--- <esc>a
"" au FileType python map <buffer> <leader>1 /class 
"" au FileType python map <buffer> <leader>2 /def 
"" au FileType python map <buffer> <leader>C ?class 
"" au FileType python map <buffer> <leader>D ?def 
 
 
"""""""""""""""""""""""""""""""
"" => Jinja section
""""""""""""""""""""""""""""""""
"" au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja
 
 
"" """"""""""""""""""""""""""""""
"" " => JavaScript section
"" """""""""""""""""""""""""""""""
""
"" au FileType javascript call JavaScriptFold()
"" au FileType javascript setl fen
"" au FileType javascript setl nocindent
 
"" au FileType javascript imap <c-t> $log();<esc>hi
"" au FileType javascript imap <c-a> alert();<esc>hi
 
"" au FileType javascript inoremap <buffer> $r return 
"" au FileType javascript inoremap <buffer> $f //--- PH<esc>FP2xi
 
"" function! JavaScriptFold() 
""     setl foldmethod=syntax
""     setl foldlevelstart=1
""     syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend
 
""     function! FoldText()
""         return substitute(getline(v:foldstart), '{.*', '{...}', '')
""     endfunction
""     setl foldtext=FoldText()
"" endfunction
 
"" au FileType gitcommit call setpos('.', [0, 1, 1, 0])
 
 
"""""""""""""""""""""""""""""""
"" => bufExplorer plugin
"""""""""""""""""""""""""""""""
"" let g:bufExplorerDefaultHelp=0
"" let g:bufExplorerShowRelativePath=1
"" let g:bufExplorerFindActive=1
"" let g:bufExplorerSortBy='name'
"" map <leader>o :BufExplorer<cr>
 
 
"""""""""""""""""""""""""""""""
"" => MRU plugin
"""""""""""""""""""""""""""""""
"" let MRU_Max_Entries = 400
"" map <leader>f :MRU<CR>
 
 
"""""""""""""""""""""""""""""""
"" => YankStack
"""""""""""""""""""""""""""""""
"" nmap <c-p> <Plug>yankstack_substitute_older_paste
"" nmap <c-P> <Plug>yankstack_substitute_newer_paste
 
 
"""""""""""""""""""""""""""""""
"" => CTRL-P
"""""""""""""""""""""""""""""""
"let g:ctrlp_working_path_mode = 0
 
"let g:ctrlp_map = '<c-f>'
"map <leader>j :CtrlP<cr>
"map <c-b> :CtrlPBuffer<cr>
 
"let g:ctrlp_max_height = 20
"let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'
 
 
"""""""""""""""""""""""""""""""
"" => ZenCoding
"""""""""""""""""""""""""""""""
"" Enable all functions in all modes
"" let g:user_zen_mode='a'
 
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                vim-notes                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:notes_directories = ['~/Dropbox/notes']
let g:notes_suffix = '.md'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                tagbar                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" let g:tagbar_left = 1
"let g:tagbar_sort = 0
"" if has("gui_macvim")
""   let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
"" endif
 
nnoremap <F4> :TagbarToggle<cr><c-w>=
 
 
"""""""""""""""""""""""""""""""
"" => snipMate (beside <TAB> support <CTRL-j>)
"""""""""""""""""""""""""""""""
"ino <c-j> <c-r>=snipMate#TriggerSnippet()<cr>
"snor <c-j> <esc>i<right><c-r>=snipMate#TriggerSnippet()<cr>
 
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Youcompleteme.vim config
"" 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:ycm_autoclose_preview_window_after_completion=1
map <leader>d  :YcmCompleter GoToDefinitionElseDeclaration<CR>
 
""make ycm compatible with ultisnips 
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0

let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'

let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
 
"""""""""""""""""""""""""""""""
"" => Vim grep
"""""""""""""""""""""""""""""""
"" let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
"" set grepprg=/bin/grep\ -nH
 
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Nerd Tree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" let g:NERDTreeWinPos = "right"
"let NERDTreeShowHidden=0
"let NERDTreeIgnore = ['\.pyc$', '__pycache__']
"let g:NERDTreeWinSize=35
"" map <leader>nn :NERDTreeToggle<cr>
"" map <leader>nb :NERDTreeFromBookmark
" map <leader>nf :NERDTreeFind<cr>

noremap <F3> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:multi_cursor_next_key="\<C-s>"
 
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => surround.vim config
"" Annotate strings with gettext http://amix.dk/blog/post/19678
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" vmap Si S(i_<esc>f)
"" au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>
 
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => lightline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Always show the status line
set laststatus=2

function! LightLineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \ },
      \   'component_function': {
      \       'fugitive': 'LightLineFugitive',
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \ },
      \ }


"      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
"      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }

"    return "🔒"
 "let g:airline_symbols.branch = ''
 " let g:airline_symbols.readonly = ''
 " let g:airline_symbols.linenr = ''
       "  'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
"" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
 
" set noshowmode

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Vim-go
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" let g:go_fmt_command = "goimports"
 
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Syntastic (syntax checker)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python
" let g:syntastic_python_checkers=['pyflakes']
" let g:syntastic_python_checkers=['python', 'pep8']
" let g:syntastic_python_checkers=['pylint']
let g:syntastic_python_checkers=['python', 'flake8']

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1

"" " Javascript
"" let g:syntastic_javascript_checkers = ['jshint']
 
"" " Go
"" let g:syntastic_auto_loc_list = 1
"" let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Git gutter (Git diff)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_enabled=1
"" nnoremap <silent> <leader>g :GitGutterToggle<cr>
""

" 'quote' a word
nnoremap qw :silent! normal mpea'<Esc>bi'<Esc>`pl
" double 'quote' a word
nnoremap qe :silent! normal mpea"<Esc>bi"<Esc>`pl
" remove quotes from a word
nnoremap wq :silent! normal mpeld bhd `ph<CR>

" prettyfy json file
" map <Leader>j %!python -m json.tool<CR>
autocmd FileType json autocmd BufWritePre <buffer> %!python -m json.tool
 
" py lint trigger
map <leader>pl :SyntasticCheck pylint<cr>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"nnoremap <F8> :call Loadnotes()<cr><c-w>=
"function Loadnotes()
"   :e ~/Dropbox/notes
"endfunction

"show white space
set listchars=eol:¬,tab:▸.,trail:~,extends:>,precedes:<,space:␣
nmap <leader>l :set list!<CR>

" :set list

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>L :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
