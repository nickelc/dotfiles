syntax on
filetype plugin indent on

" Basic settings and variables {{{
set number relativenumber
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
set colorcolumn=80
" Display tabs and trailing space visually
set list listchars=tab:\ \ ,trail:·

let mapleader=","
" }}}

" Plugins {{{
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'preservim/tagbar'
Plug 'vim-airline/vim-airline'

Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'Yggdroot/indentLine'
Plug 'tomtom/tcomment_vim'

Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'

Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'gruvbox-community/gruvbox'
Plug 'joshdick/onedark.vim'
call plug#end()
" }}}

" Theme & Colors {{{
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection = 0

colorscheme gruvbox
set background=dark

highlight LineNr guifg=#5eacd3
highlight netrwDir guifg=#5eacd3
highlight qfFileName guifg=#aed75f
" }}}

" Auto-commands {{{
autocmd FileType json setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab
" }}}

" Keyboard Shortcuts and remappings {{{

" Keymaps for the idiotic keyboard layout
noremap ł \|
noremap » <
noremap « >
noremap! ł \|
noremap! » <
noremap! « >

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

" Git
nnoremap <leader>gs :G<CR>
nnoremap <leader>gc :GBranches<CR>
nnoremap <leader>gf :diffget //2<CR>
nnoremap <leader>gj :diffget //3<CR>

" fzf
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>pf :Files<CR>

" Command aliases for fat-fingering
command! Q q
command! Qa qa
command! W w
command! Wq wq

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

" CoC {{{
let g:coc_global_extensions = ['coc-rust-analyzer', 'coc-json', 'coc-yaml', 'coc-vimlsp']
"

" fzf & fzf-checkout {{{
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_branch_actions = {
    \ 'rebase': {
    \   'confirm': v:false,
    \ },
    \}
" }}}

" airline {{{
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_symbols.branch = ''
let g:airline_symbols.maxlinenr = ''
" }}}

" tagbar {{{
let g:tagbar_autofocus = 1
let g:tagbar_autoshowtag = 1

nmap <F8> :TagbarToggle<CR>
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
