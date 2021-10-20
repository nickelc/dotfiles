lua require('me.telescope')

nnoremap <C-p> :lua require('me.telescope').project_files()<CR>
nnoremap <leader>pf :Telescope find_files<CR>
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep for > ') })<CR>
nnoremap <leader>pw :lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })<CR>
nnoremap <leader>pb :Telescope buffers<CR>
nnoremap <leader>pr :Telescope resume<CR>
