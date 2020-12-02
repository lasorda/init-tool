call plug#begin('~/.vim/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdcommenter'
Plug 'ervandew/supertab'
Plug 'rking/ag.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --go-completer --rust-completer'}
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go'
Plug 'rhysd/vim-clang-format'
call plug#end()

" aireline
let g:airline_theme='simple'
set t_Co=256
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.whitespace = 'Ξ'

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_c = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

" tarbar
autocmd BufNewFile,BufRead * :TagbarOpen
nmap <F4> :TagbarToggle<CR>

" better_whitespace
let g:better_whitespace_enabled=0
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" YouComleteMe
" let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_server_python_interpreter='/usr/bin/python3'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
" compatible with supertab, trigger with <C-space>
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_enable_diagnostic_signs = 0
set completeopt=menu,menuone
map <c-]> :YcmCompleter GoTo<CR>

" clang format
nmap <C-L> :ClangFormat<CR>

" other
nmap <c-n> :bnext<CR>
nmap <c-p> :bprevious<CR>
set shiftwidth=4
set tabstop=4
set expandtab
set number
set incsearch
set hlsearch
map <F2> :set nu!<CR>
set hidden
set fileencodings=utf8
set wildmenu wildmode=full
set wildchar=<Tab> wildcharm=<C-Z>
