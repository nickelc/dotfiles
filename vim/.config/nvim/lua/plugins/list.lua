return function(use)
    use { 'wbthomason/packer.nvim', opt = true }

    use 'tpope/vim-vinegar'
    use 'preservim/nerdtree'
    use 'Xuyuanp/nerdtree-git-plugin'
    use 'preservim/tagbar'
    use 'vim-airline/vim-airline'
    use 'mbbill/undotree'

    use 'jeffkreeftmeijer/vim-numbertoggle'
    use 'Yggdroot/indentLine'
    use 'tomtom/tcomment_vim'

    use 'rust-lang/rust.vim'
    use 'cespare/vim-toml'

    -- git
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'junegunn/gv.vim'

    use { 'neoclide/coc.nvim', branch = 'release' }

    -- telescope plugins
    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim',
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    use 'gruvbox-community/gruvbox'
end
