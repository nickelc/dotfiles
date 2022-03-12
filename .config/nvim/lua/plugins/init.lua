local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'
local compile_path = vim.fn.stdpath 'data' .. '/plugin/packer_compiled.lua'
local repo_url = 'https://github.com/wbthomason/packer.nvim'

local ok, packer = pcall(require('plugins.bootstrap'), install_path, compile_path, repo_url)
if not ok or not packer then return end

local config = {
    compile_path = compile_path,
}

packer.init(config)
packer.startup(require('plugins.list'))

if vim.loop.fs_stat(config.compile_path) then
    vim.cmd('luafile ' .. config.compile_path)
else
    packer.sync()
end

vim.cmd 'autocmd BufWritePost */plugins/list.lua source <afile> | PackerCompile'

local plugins = setmetatable({}, {
    __index = function(_, key)
        return packer[key]
    end
})

return plugins
