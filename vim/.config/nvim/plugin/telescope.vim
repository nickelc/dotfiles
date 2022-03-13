nnoremap <C-p> :lua require('me.telescope').project_files()<CR>
nnoremap <leader>pf :Telescope find_files<CR>
nnoremap <leader>ps :lua require('me.telescope').grep_input()<CR>
nnoremap <leader>pw :lua require('me.telescope').grep_cword()<CR>
nnoremap <leader>pb :Telescope buffers<CR>
nnoremap <leader>pr :Telescope resume<CR>
