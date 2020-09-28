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
