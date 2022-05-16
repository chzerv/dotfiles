-----------------------------------------------
-- Initialize packer.nvim
-- https://github.com/wbthomason/packer.nvim
-----------------------------------------------

-- Automatically install packer
local fn = vim.fn
local nvim_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(nvim_path)) > 0 then
    packer_bootstrap = fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        nvim_path
    })
end

-- Reload neovim whenever this file is changed
vim.cmd [[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]]

return require('packer').startup(function()
    -- Let packer manage itself
    use 'wbthomason/packer.nvim'

    -- Smart comments
    use 'numToStr/Comment.nvim'

    -- Better % functionality
    use 'andymass/vim-matchup'

    -- Autopairs
    use 'windwp/nvim-autopairs'

    -- Indent guides
    -- Only needed for specific filetypes
    use 'lukas-reineke/indent-blankline.nvim'

    -- Tree sitter
    -- Enable vim-matchup support for tree-sitter
    -- Also run ':TsInstall bash c dockerfile go javascript python json rust yaml'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }

    -- LSP
    use {
        "williamboman/nvim-lsp-installer",
        "neovim/nvim-lspconfig",
    }

    -- Autocompletion
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'hrsh7th/cmp-buffer' -- Source for buffer words
    use 'hrsh7th/cmp-path' -- Source for paths
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-nvim-lua' -- Source for the neovim Lua API
    use 'onsails/lspkind.nvim'

    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- telescope.nvim
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }

    -- Appearance
    -- use 'navarasu/onedark.nvim'
    -- use 'shaunsingh/nord.nvim'
    use{
        "catppuccin/nvim",
        as = "catppuccin"
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Improve navigation inside tmux
    use 'christoomey/vim-tmux-navigator'

    -- Delete/add/change parentheses, tags etc
    use 'tpope/vim-surround'

    -- Git integration
    use 'lewis6991/gitsigns.nvim'
    use 'tpope/vim-fugitive'

    -- LaTeX
    use 'lervag/vimtex'

    if packer_bootstrap then
        require('packer').sync()
    end
end)
