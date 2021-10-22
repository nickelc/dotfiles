syntax on
filetype plugin indent on

" Basic settings and variables {{{
set exrc
set number relativenumber
set nowrap
set noerrorbells
set nohlsearch
set hidden
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
set signcolumn=yes

set cmdheight=2

" Display tabs and trailing space visually
set list listchars=tab:\ \ ,trail:·

let mapleader=" "
" }}}

" Plugins {{{
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'preservim/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'mbbill/undotree'

Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'Yggdroot/indentLine'
Plug 'tomtom/tcomment_vim'

Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" telescope requirements...
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

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
autocmd FileType gitconfig setlocal expandtab!
autocmd FileType json setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab
" }}}

" Keyboard Shortcuts and remappings {{{

" yank till eol; behave like D and C
nnoremap Y y$

" Keep it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Undo break points
inoremap . .<C-g>u
inoremap , ,<C-g>u
inoremap ? ?<C-g>u

" Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

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
nnoremap <leader>gc :Telescope git_branches<CR>
nnoremap <leader>gf :diffget //2<CR>
nnoremap <leader>gj :diffget //3<CR>

" tagbar
nmap <F8> :TagbarToggle<CR>

" Undo
nnoremap <leader>u :UndotreeShow<CR>

" Command aliases for fat-fingering
command! Q q
command! Qa qa
command! W w
command! Wq wq

"changes with less keystrokes
" nnoremap . :
" Space to toggle folds.
" nnoremap <Space> za
" vnoremap <Space> za

" Window navigation
nmap <silent> <leader>h :wincmd h<CR>
nmap <silent> <leader>j :wincmd j<CR>
nmap <silent> <leader>k :wincmd k<CR>
nmap <silent> <leader>l :wincmd l<CR>
nmap <silent> <leader><Left> :wincmd h<CR>
nmap <silent> <leader><Down> :wincmd j<CR>
nmap <silent> <leader><Up> :wincmd k<CR>
nmap <silent> <leader><Right> :wincmd l<CR>

" Window resize
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>

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
let g:coc_global_extensions += ['coc-toml', 'coc-highlight']

autocmd CursorHold * call CocActionAsync('highlight')
" }}}

" airline {{{
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.maxlinenr = ''
" }}}

" indentLine {{{
let g:indentLine_leadingSpaceEnabled = 0
let g:indentLine_leadingSpaceChar = '·'
" let g:indentLine_char = '┊'
" }}}

" numbertoggle {{{
:nnoremap <silent> <C-n> :set relativenumber!<CR>
" }}}

" tagbar {{{
let g:tagbar_autofocus = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_sort = 0
" }}}

" vim: set sw=4 sts=4 et fdm=marker:
