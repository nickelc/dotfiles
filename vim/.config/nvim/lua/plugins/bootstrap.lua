local fn = vim.fn

return function(install_path, compile_path, repo_url)
    if not install_path then
        install_path = fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'
    end

    if not compile_path then
        compile_path = fn.stdpath 'data' .. '/plugin/packer_compiled.lua'
    end

    if not repo_url then
        repo_url = 'https://github.com/wbthomason/packer.nvim'
    end

    local res, packer
    local is_installed = vim.loop.fs_stat(install_path) ~= nil

    if is_installed then
        vim.cmd 'packadd packer.nvim'
        res, packer = pcall(require, 'packer')
    end

    if not res and fn.input('Install packer.nvim? [y/N]: ') == 'y' then
        print 'Cloning packer.nvim...\n'
        fn.delete(install_path, 'rf')
        fn.delete(compile_path, 'rf')
        fn.system { 'git', 'clone', '--depth', '1', repo_url, install_path }

        vim.cmd 'packadd packer.nvim'
        res, packer = pcall(require, 'packer')

        if res then
            print 'Successfully installed packer.nvim'
        else
            print(('Error installing packer.nvim\nPath: %s'):format(install_path))
            return
        end
    end

    return res and packer or nil
end
