syntax on
filetype plugin indent on

" Basic settings and variables {{{
set number
set nowrap
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set autoindent smartindent copyindent shiftround
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set showmatch
set smartcase
set foldmethod=marker
set foldlevel=1
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set termguicolors
set scrolloff=8
set mouse=a
set modeline
set modelines=10
" Display tabs and trailing space visually
set list listchars=tab:\ \ ,trail:·

let mapleader=","
let g:mapleader=","
" }}}

" Plugins {{{
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'preservim/tagbar'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'Yggdroot/indentLine'
Plug 'tomtom/tcomment_vim'
Plug 'cespare/vim-toml'
Plug 'vim-airline/vim-airline'
Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
" }}}

" Auto-commands {{{
autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab
" }}}

" Keyboard Shortcuts and remappings {{{

" CoC completion {{{
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <C-space> coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" }}}

" CoC - code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" coc-codeaction fails with 'No code actions available'
" nmap <silent> ga <Plug>(coc-codeaction)
nmap <silent> ga :CocAction<CR>

"changes with less keystrokes
" nnoremap . :
" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za
" Tabs - Navigation
nnoremap th :tabfirst<CR>
nnoremap tj :tabprev<CR>
nnoremap tk :tabnext<CR>
nnoremap tl :tablast<CR>
" }}}

" Plugin configuration {{{
" NERDTree {{{
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore =['\~$', '\.git$', '\.hg$', '\.svn$', 'node_modules$', 'target$', 'Cargo.lock']
let NERDTreeQuitOnOpen = 1

" Open a NERDTree on startup
"autocmd VimEnter * NERDTree

" Open a NERDTree if no file is given as CLI argument
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"autocmd BufEnter * NERDTreeMirror

" Close if the only remaining window is a nerdtree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

nmap <Leader>f :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
" }}}

" airline {{{
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_symbols.maxlinenr = ''
" }}}

" Syntastic {{{
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_error_symbol         = '✗'
let g:syntastic_warning_symbol       = '⚠'
let g:syntastic_style_error_symbol   = '✠'
let g:syntastic_style_warning_symbol = '≈'

let g:syntastic_rust_checkers = ["cargo"]

let g:syntastic_mode_map = {
            \ "mode": "passive",
            \ "active_filetypes": [],
            \ "passive_filetype": []
            \ }
" }}}

" tagbar {{{
let g:tagbar_autofocus = 1
let g:tagbar_autoshowtag = 1

nmap <F8> :TagbarToggle<CR>
" }}}

" ack {{{
" Use ripgrep for searching ⚡️
" Options include:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge sql file dumps as it slows down the search
" --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'

" Auto close the Quickfix list after pressing '<enter>' on a list item
let g:ack_autoclose = 1

" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!

" Maps <leader>/ so we're ready to type the search keyword
nnoremap <Leader>/ :Ack!<Space>
" }}}

" indentLine {{{
let g:indentLine_leadingSpaceEnabled = 0
let g:indentLine_leadingSpaceChar = '·'
" let g:indentLine_char = '┊'
" }}}

" numbertoggle {{{
:nnoremap <silent> <C-n> :set relativenumber!<CR>
" }}}
" }}}

" vim: set sw=4 sts=4 et fdm=marker:
