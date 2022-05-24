set nocompatible              " be iMproved, required
set termguicolors
set completeopt-=preview
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
Plug 'tpope/vim-rhubarb'
" Plug 'benekastah/neomake'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'janko-m/vim-test'
" Plug 'mhinz/vim-startify'
" Plug 'sheerun/vim-polyglot'
Plug 'vim-python/python-syntax'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lifepillar/vim-colortemplate'
" Plug 'kyazdani42/nvim-web-devicons'
" Plug 'romgrk/barbar.nvim'
Plug 'github/copilot.vim'

" Language specific
Plug 'vim-ruby/vim-ruby'
" Plug 'Vimjas/vim-python-pep8-indent'
Plug 'pangloss/vim-javascript'
Plug 'stephpy/vim-yaml'
Plug 'averms/black-nvim', {'do': ':UpdateRemotePlugins'}
" Plug 'psf/black'

" NOTE: don't forget to install `jedi` and `black` with pip3

" Themes
Plug 'NLKNguyen/papercolor-theme'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'itchyny/lightline.vim'
Plug 'srcery-colors/srcery-vim'
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/sonokai'
Plug 'glepnir/zephyr-nvim'
Plug 'Th3Whit3Wolf/one-nvim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'tjdevries/colorbuddy.vim'
Plug 'Th3Whit3Wolf/spacebuddy'
Plug 'marko-cerovac/material.nvim'
Plug 'rktjmp/lush.nvim'
Plug 'rakr/vim-one'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'YorickPeterse/vim-paper'
Plug 'cormacrelf/vim-colors-github'
Plug 'folke/tokyonight.nvim'
Plug 'balanceiskey/vim-framer-syntax'
Plug 'luisiacc/gruvbox-baby'

"" Docs
Plug 'parkr/vim-jekyll'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-markdown'
Plug 'suan/vim-instant-markdown'
Plug 'https://gitlab.com/protesilaos/tempus-themes-vim.git'
Plug 'preservim/vim-pencil'

call plug#end()
filetype plugin indent on
syntax on

" Goyo settings
let g:goyo_width = 101

" Gitgutter
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

" fuzzy finder
map <C-p> :FZF<cr>
nmap <C-p> :FZF<cr>

" more coloring
nnoremap <leader>rl :RainbowLevelsToggle<CR>
let g:rainbow_levels = [
    \{'ctermbg': 'none', 'level': 0},
    \{'ctermbg': 'none', 'level': 1},
    \{'ctermbg': 'none', 'level': 2},
    \{'ctermbg': 'none', 'level': 3},
    \
    \{'ctermbg': 3,   'guibg': '#ffc66d'},
    \{'ctermbg': 9,   'guibg': '#cc7833'},
    \{'ctermbg': 1,   'guibg': '#da4939'},
    \{'ctermbg': 160, 'guibg': '#870000'}]

" Linters config
let g:neomake_kotlin_ktlint_maker = {}
let g:neomake_kotlin_enabled_makers = ['ktlint']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_python_enabled_makers = ['vulture']
" autocmd! BufWritePost * Neomake
command Isort :!isort %
" command Black :!black %
command JsonPretty ':!python -m json.tool'

function! PythonFormatter()
    " execute ':Black'
    " execute ':Isort'
    call Black()
endfunction
autocmd! BufWritePre *.py call PythonFormatter()

" Semshi config
let g:semshi#simplify_markup = v:false
let g:semshi#no_default_builtin_highlight = v:false
let test#strategy = "neovim"

" Custom statusline
set statusline=[%{mode()}]%*\ %{expand('%')}%*%m%r%h%w\ 
set statusline+=\ %=                        " align left
set statusline+=%{fugitive#statusline()}%*
set statusline+=%y[\%{&ff}:%{strlen(&fenc)?&fenc:&enc}]
set statusline+=\ [\%c:\%l\/%L]

let g:lightline = {
            \'component_function': {'filename': 'FilenameForLightline'}
            \}
let g:lightline.colorscheme = 'gruvbox_material'
let g:gruvbox_material_background = 'hard'
" let g:gruvbox_material_palette = 'mix'
let g:gruvbox_material_diagnostic_text_highlight = 1
let g:gruvbox_material_diagnostic_line_highlight = 1
let g:tokyonight_style = "day"

" Show full path of filename
function! FilenameForLightline()
    return expand('%')
    " return expand('%')}%*%m%r%h%w
endfunction

" Default settings for everything
set shell=/usr/local/bin/bash
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
set signcolumn=yes

" Color schemes
if &t_Co >= 256 || has("gui_running")
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
    set background=dark
    colorscheme queque
    " colorscheme gruvbox-baby
endif


let g:python_highlight_all = 1

" Writings settings
noremap <Up> gk
noremap <Down> gj
autocmd FileType rst,rest,txt,text,markdown,mkd,md,rfc call SetTextSettings()
function! SetTextSettings()
    " set wrap nolist
    " set linebreak
    " set wrapmargin=0
    " set spell spelllang=en_us
    let g:pencil#wrapModeDefault = 'soft'
    let g:pencil#textwidth = 74
    call pencil#init()
    colorscheme papercolor
endfunction

" Python settings
let g:python_host_prog  = '/usr/local/bin/python3'
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

" Python highlights
" hi! link pythonBuiltinObj SrceryBrightMagenta
" hi! link pythonRepeat SrceryOrangeBold
" hi! link pythonConditional SrceryBrightOrange
" hi! link pythonOperator SrceryBrightOrange
" hi! link pythonInclude SrceryBlueBold
" hi! link pythonSelf SrceryRed
" hi! link pythonStatement SrceryBrightRed

" current highlight group
function! g:SyntaxGroup() abort
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction
nnoremap <F12> :call SyntaxGroup()<CR>

"" Copy to clip board
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

" function! MakeTransform(cmd) abort
"   let tests_path = split(a:cmd)[-1]
"   return 'make integration_tests test='.substitute(tests_path, 'src\.', '', '')
" endfunction
" let g:test#custom_transformations = {'make': function('MakeTransform')}
" let g:test#transformation = 'make'


" sherpany-specific
let g:test#python#runner = "djangotest"
function! RunpyTransform(cmd) abort
  let tests_path = split(a:cmd)[-1]
  return 'python3 ./run.py unit_tests '.substitute(tests_path, 'src\.', '', '')
endfunction
let g:test#custom_transformations = {'runpy': function('RunpyTransform')}
let g:test#transformation = 'runpy'
