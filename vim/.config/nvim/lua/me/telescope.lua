require('telescope').setup({
    defaults = {
        sorting_strategy = 'ascending',
        layout_config = {
            prompt_position = 'top',
        }
    }
})

require('telescope').load_extension('fzf')
