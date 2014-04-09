set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"" Plugins and bundles
Plugin 'gmarik/vundle'
Bundle 'bling/vim-airline'
Bundle 'godlygeek/csapprox'
Bundle 'altercation/vim-colors-solarized'
Bundle 'pangloss/vim-javascript'
Bundle 'hynek/vim-python-pep8-indent'

"" vim-airline settings
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled=1

"" custom settings
filetype plugin indent on
syntax on

set hidden
set nowrap        " don't wrap lines
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set number        " always show line numbers
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
set cursorline
set paste 
set colorcolumn=80
set cindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set cinkeys=0{,0},:,0#,!,!^F
set mouse=a
set encoding=utf-8

if &t_Co >= 256 || has("gui_running")
    set background=dark
    let g:solarized_termcolors=256
    let g:solarized_visibility='high'
    let g:solarized_contrast='high'
    colorscheme solarized 
    hi CursorLine term=None cterm=None 
endif


" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>

" Sidebar explorer configs
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_liststyle=3
let g:netrw_list_hide = "\.pyc,\.swp,\.bak,\.git"
let g:netrw_special_syntax = 1
let g:netrw_liststyle = 1
