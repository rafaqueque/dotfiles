set nocompatible              " be iMproved, required
filetype off                  " required

"" Install vim-plug
"" $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

"" Plugins and bundles
call plug#begin('~/.vim/plugged')
" Misc
" Plug 'bsl/obviousmode'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar', { 'on': ['TagbarToggle'] }
" JS
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'html', 'htmldjango'] }
Plug 'jelera/vim-javascript-syntax', { 'for': ['javascript', 'html', 'htmldjango'] }
" Markdown
Plug 'itspriddle/vim-jekyll', { 'for': ['md', 'markdown', 'txt', 'liquid'] }
Plug 'tpope/vim-markdown', { 'for': ['md', 'markdown', 'txt', 'liquid'] }
Plug 'junegunn/goyo.vim'
" Python
Plug 'hdima/python-syntax', { 'for': ['python'] }
Plug 'hynek/vim-python-pep8-indent', { 'for': ['python'] }
Plug 'benekastah/neomake'
call plug#end()

"" custom settings
filetype plugin indent on
syntax on

let g:neomake_python_enabled_makers = ['pep8', 'flake8']
let g:neomake_python_pep8_maker = {
    \ 'args': ['--max-line-length 99'],
    \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
    \ }
autocmd! BufWritePost * Neomake

"" custom statusline
set statusline=%#ErrorMsg#[%{mode()}]%*\ %f%m%r%h%w\ 
set statusline+=\ %=                        " align left
set statusline+=%{fugitive#statusline()}
set statusline+=[%{strlen(&fenc)?&fenc:&enc}]
set statusline+=\ [\%c:\%l\/%L]

let g:PyFlakeDisabledMessages = 'E501'
let g:PyFlakeMaxLineLength = '100'

set hidden
set nowrap        " don't wrap lines
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
set wildignore=*.swp,*.bak,*.pyc,*.class
set title
set visualbell
set noerrorbells
set nobackup
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

if &t_Co >= 256 || has("gui_running")
    if has("gui_running")
        set guifont=Source\ Code\ Pro\ Light:h12
        set columns=999
        set linespace=1
        set go-=r
        set go-=L
        set go-=T
    endif
    set background=light
    colorscheme flattown
endif


nmap <silent> <F8> :TagbarToggle<CR>

" Toggle mouse and numbers
nnoremap <F5> :call ToggleMouse()<CR>
function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
    echo "Mouse usage disabled"
  else
    set mouse=a
    echo "Mouse usage enabled"
  endif
endfunction

" Sidebar explorer configs
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_liststyle=3
let g:netrw_list_hide = "\.pyc,\.swp,\.bak,\.git"
let g:netrw_special_syntax = 1
let g:netrw_liststyle = 1

" vim-pencil settings
autocmd FileType txt,text,markdown,mkd,md call SetTextSettings() 
function! SetTextSettings()
    set nofoldenable wrap linebreak nolist tw=74
endfunction
autocmd FileType python call SetPythonSettings()
function! SetPythonSettings()
    match ErrorMsg '\%>100v.\+'
endfunction

noremap <C-t> :below 10sp term://$SHELL<cr>if
nnoremap <F9> "=strftime("%c")<CR>P
inoremap <F9> <C-R>=strftime("%c")<CR>
