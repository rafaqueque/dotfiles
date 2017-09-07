set nocompatible              " be iMproved, required
set termguicolors
filetype off                  " required

"" Install vim-plug
"" $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

"" Plugins and bundles
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Misc
Plug 'tpope/vim-fugitive'
Plug 'benekastah/neomake'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'blueyed/vim-diminactive'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'janko-m/vim-test'
Plug 'mhinz/vim-startify'

" Language specific
Plug 'vim-ruby/vim-ruby'
Plug 'hynek/vim-python-pep8-indent'
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'stephpy/vim-yaml'

" Themes
Plug 'chriskempson/base16-vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'tpope/vim-vividchalk'
" Others:
" 'rhysd/vim-color-spring-night'
" 'bruth/vim-newsprint-theme'
" 'bluz71/vim-moonfly-statusline'
" 'rakr/vim-one'
" 'tyrannicaltoucan/vim-quantum'

" Docs
Plug 'parkr/vim-jekyll'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-markdown'
Plug 'suan/vim-instant-markdown'

call plug#end()
filetype plugin indent on
syntax on

" Goyo settings
let g:goyo_width = 101
let g:deoplete#enable_at_startup = 1
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

let g:jsx_ext_required = 0

" Ctrl-p settings
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" if executable('ag')
"   set grepprg=ag\ --nogroup\ --nocolor
"   let g:ctrlp_user_command = 'ag %s -l --nocolor -g \""'
" endif
" if executable('fzf')
"   let g:ctrlp_user_command = 'fzf'
" endif
map <C-p> :FZF<cr>
nmap <C-p> :FZF<cr>

" Linters config
let g:neomake_kotlin_ktlint_maker = {}
let g:neomake_kotlin_enabled_makers = ['ktlint']

let g:neomake_javascript_enabled_makers = ['eslint']

let g:neomake_python_enabled_makers = ['pep8', 'flake8']
let g:neomake_python_pep8_maker = {
    \ 'args': ['--max-line-length 99'],
    \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
    \ }
autocmd! BufWritePost * Neomake

let test#strategy = "neovim"

" Custom statusline
" set statusline=[%{mode()}]%*\ %{expand('%')}%*%m%r%h%w\ 
" set statusline+=\ %=                        " align left
" set statusline+=%{fugitive#statusline()}%*
" set statusline+=%y[\%{&ff}:%{strlen(&fenc)?&fenc:&enc}]
" set statusline+=\ [\%c:\%l\/%L]

" Default settings for everything
set hidden
set nowrap        " don't wrap lines
set list
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set nonumber        " always show line numbers
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set undolevels=1000 " use many muchos levels of undo
set title
set visualbell
set noerrorbells
set nobackup
set nocursorline
set backupdir-=.
set backupdir^=~/tmp,/tmp
set noswapfile
set laststatus=2
set t_Co=256
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set cinkeys=0{,0},:,0#,!,!^F
set mouse=a
set encoding=utf-8
set nopaste
set pastetoggle=<F7>
set nofoldenable    " disable folding
set nosol
set wildignore=*.swp,*.bak,*.pyc,*.class
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

" Color schemes
if &t_Co >= 256 || has("gui_running")
    " if has('nvim')
    " let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    " endif
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
    set background=dark
    colorscheme PaperColor
endif

" Custom mappings
nmap <silent> <F8> :TagbarToggle<CR>
nmap <silent> <C-e> :NERDTreeToggle<CR>
nnoremap <F5> :call ToggleMouse()<CR>
nnoremap <F9> "=strftime("%c")<CR>P
inoremap <F9> <C-R>=strftime("%c")<CR>

" Toggle mouse and numbers
function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
    echo "Mouse usage disabled"
  else
    set mouse=a
    echo "Mouse usage enabled"
  endif
endfunction

let g:python_highlight_all = 1

" Sidebar explorer configs
let NERDTreeIgnore = ['\.pyc$', '\.swp$', '\.bak$', '\.git$']
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_liststyle=3
let g:netrw_list_hide = "\.pyc,\.swp,\.bak,\.git"
let g:netrw_special_syntax = 1
let g:netrw_liststyle = 1

" Writings settings
autocmd FileType rst,rest,txt,text,markdown,mkd,md,rfc call SetTextSettings()
function! SetTextSettings()
    set wrap nolist tw=74
endfunction

" Python settings
autocmd FileType python call SetPythonSettings()
function! SetPythonSettings()
    match errormsg '\%>100v.\+'
    set expandtab
    set tabstop=4 shiftwidth=4 softtabstop=4
    set autoindent
    set smarttab
endfunction

" Ruby settings
autocmd FileType ruby call SetRubySettings()
function! SetRubySettings()
    set expandtab
    set tabstop=2 shiftwidth=2 softtabstop=2
    set autoindent
endfunction

hi User1 cterm=bold gui=bold ctermfg=yellow ctermbg=darkgreen guifg=yellow guibg=darkgreen
hi User2 cterm=bold gui=bold ctermfg=red ctermbg=darkgreen guifg=red guibg=darkgreen
hi StatusLine cterm=none gui=none ctermfg=white ctermbg=darkgreen guifg=white guibg=darkgreen
hi TabLineFill ctermfg=white ctermbg=green guifg=white guibg=green
hi TabLine ctermfg=white ctermbg=green guifg=white guibg=green
hi TabLineSel cterm=bold gui=bold ctermfg=white ctermbg=darkgreen guifg=white guibg=darkgreen

" current highlight group
" echo synIDattr(synID(line("."),col("."),1),"name")

" Copy to clip board
set clipboard=unnamed

autocmd User Startified setlocal cursorline

let g:mucomplete#enable_auto_at_startup = 1

let g:startify_enable_special         = 0
let g:startify_files_number           = 5
let g:startify_relative_path          = 1
let g:startify_change_to_dir          = 1
let g:startify_update_oldfiles        = 1
let g:startify_session_autoload       = 1
let g:startify_session_persistence    = 1

let g:startify_skiplist = [
        \ 'COMMIT_EDITMSG',
        \ 'bundle/.*/doc',
        \ ]

let g:startify_bookmarks = [
        \ { 'v': '~/.vimrc' },
        \ { 'z': '~/.zshrc' },
        \ ]

let g:startify_commands = [
        \ {'p': ':PlugUpdate'},
        \ ]

hi StartifyBracket ctermfg=240
hi StartifyFile    ctermfg=147
hi StartifyFooter  ctermfg=240
hi StartifyHeader  ctermfg=114
hi StartifyNumber  ctermfg=215
hi StartifyPath    ctermfg=245
hi StartifySlash   ctermfg=240
hi StartifySpecial ctermfg=240
