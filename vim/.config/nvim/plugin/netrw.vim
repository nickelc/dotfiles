let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_hide = 1
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Open netrw if no file is given as CLI argument
augroup netrw_open
    autocmd!
    autocmd StdinReadPre * let s:std_in = 1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Vexplore
augroup END

" Close if the only remaining window is netrw
augroup netrw_close
    autocmd!
    autocmd BufEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" | quit
augroup END
