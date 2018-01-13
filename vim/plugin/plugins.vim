" NERDTree {{{
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
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

" Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

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

" indentLine {{{
let g:indentLine_leadingSpaceEnabled = 0
let g:indentLine_leadingSpaceChar = '·'
" let g:indentLine_char = '┊'
" }}}

" markdown-composer {{{
let g:markdown_composer_open_browser=0
" }}}

" gpg {{{
let g:GPGUsePipes=1
" }}}

" latexsuite: set output to pdf {{{
let g:Tex_DefaultTargetFormat="pdf"
let g:Tex_MultipleCompileFormats="pdf, aux"
" Disable QuickFix window and goto error
" let g:Tex_GoToError=0
" }}}

" numbertoggle {{{
:nnoremap <silent> <C-n> :set relativenumber!<CR>
" }}}

" bufferline {{{
let g:bufferline_echo = 0
" }}}

" vim: set sw=4 sts=4 et fdm=marker:
