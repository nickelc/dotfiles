local actions = require('telescope.actions')

require('telescope').setup({
    defaults = {
        sorting_strategy = 'ascending',
        layout_config = {
            prompt_position = 'top',
        },
        mappings = {
            i = {
                ['<C-Up>'] = actions.preview_scrolling_up,
                ['<C-Down>'] = actions.preview_scrolling_down,
            },
            n = {
                ['<C-Up>'] = actions.preview_scrolling_up,
                ['<C-Down>'] = actions.preview_scrolling_down,
            },
        },
    },
    pickers = {
        find_files = {
            find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
        },
    },
})

require('telescope').load_extension('fzf')

local M = {}

M.grep_cword = function()
    require('telescope.builtin').grep_string({
        search = vim.fn.expand('<cword>'),
    })
end

M.grep_input = function()
    require('telescope.builtin').grep_string({
        search = vim.fn.input('Grep for > '),
    })
end

M.project_files = function()
    local ok = pcall(require('telescope.builtin').git_files)
    if not ok then
        require('telescope.builtin').find_files()
    end
end

return setmetatable({}, {
    __index = function(_, k)
        if M[k] then
            return M[k]
        else
            return require('telescope.builtin')[k]
        end
    end,
})
