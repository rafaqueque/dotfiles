set nocompatible              " be iMproved, required
set termguicolors
filetype off                  " required

"" Install vim-plug
"" $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

"" Plugins and bundles
call plug#begin('~/.vim/plugged')
" Misc
Plug 'tpope/vim-fugitive'
Plug 'benekastah/neomake'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'janko-m/vim-test'
Plug 'blueyed/vim-diminactive'
Plug 'ciaranm/detectindent'
Plug 'tpope/vim-endwise'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'

" Language specific
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-scripts/smarty-syntax'
Plug 'hynek/vim-python-pep8-indent'
Plug 'elixir-lang/vim-elixir'
Plug 'jelera/vim-javascript-syntax'
Plug 'udalov/kotlin-vim'
Plug 'suan/vim-instant-markdown'
Plug 'mustache/vim-mustache-handlebars'

" Themes
Plug 'chriskempson/base16-vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'rhysd/vim-color-spring-night'
Plug 'bruth/vim-newsprint-theme'

" Docs
Plug 'mhinz/vim-rfc'
Plug 'vim-scripts/rfc-syntax', { 'for': 'rfc' }
Plug 'parkr/vim-jekyll'
Plug 'junegunn/goyo.vim'

call plug#end()
filetype plugin indent on
syntax on

" Goyo settings
let g:goyo_width = 101
let g:deoplete#enable_at_startup = 1
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

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

let g:neomake_python_enabled_makers = ['pep8', 'flake8']
let g:neomake_python_pep8_maker = {
    \ 'args': ['--max-line-length 99'],
    \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
    \ }
autocmd! BufWritePost * Neomake

" Custom statusline
set statusline=[%{mode()}]%*\ %{expand('%')}%*%m%r%h%w\ 
set statusline+=\ %=                        " align left
set statusline+=%{fugitive#statusline()}%*
set statusline+=%y[\%{&ff}:%{strlen(&fenc)?&fenc:&enc}]
set statusline+=\ [\%c:\%l\/%L]

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
autocmd FileType ruby,eruby,javascript call SetRubySettings()
function! SetRubySettings()
    match errormsg '\%>100v.\+'
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

autocmd BufReadPost * :DetectIndent

" current highlight group
" echo synIDattr(synID(line("."),col("."),1),"name")
