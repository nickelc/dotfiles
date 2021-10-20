require('telescope').setup({
    defaults = {
        sorting_strategy = 'ascending',
        layout_config = {
            prompt_position = 'top',
        }
    }
})

require('telescope').load_extension('fzf')

local M = {}

M.project_files = function()
    local ok = pcall(require('telescope.builtin').git_files)
    if not ok then
        require('telescope.builtin').find_files()
    end
end

return M
