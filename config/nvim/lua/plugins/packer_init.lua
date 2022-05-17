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

-- Run :PackerSync whenever this file is updated
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PackerConfig', { clear = true }),
    pattern = 'packer_init.lua',
    command = 'source <afile> | PackerCompile',
})

return require('packer').startup({
    function(use)
        -- Let packer manage itself
        use 'wbthomason/packer.nvim'

        -- Improve startup time with caching
        use 'lewis6991/impatient.nvim'

        -- Smart comments
        use {
            'numToStr/Comment.nvim',
            config = function()
                require('plugins/nvim-comment')
            end
        }

        -- Autopairs
        use {
            'windwp/nvim-autopairs',
            after = 'nvim-cmp',
            config = function()
                require("plugins/nvim-autopairs")
            end
        }

        -- Indent guides
        -- Only needed for specific filetypes
        use {
            'lukas-reineke/indent-blankline.nvim',
            ft = { 'yaml', 'python', 'json' },
            config = function()
                require("plugins/nvim-indent-blankline")
            end
        }

        -- Tree sitter
        -- Also run ':TsInstall bash c dockerfile go javascript python json rust yaml'
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config = function()
                require("plugins/nvim-treesitter")
            end
        }

        -- LSP
        use {
            "williamboman/nvim-lsp-installer",
            "neovim/nvim-lspconfig",
        }

        -- Autocompletion
        use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
        use 'hrsh7th/cmp-nvim-lsp'

        use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
        use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }

        use 'hrsh7th/cmp-nvim-lsp-signature-help'
        use 'hrsh7th/cmp-nvim-lua'
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
            run = 'make',
            after = 'telescope.nvim',
            config = function()
                require('telescope').load_extension('fzf')
            end
        }

        -- Appearance
        use 'shaunsingh/nord.nvim'

        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }

        -- Improve navigation inside tmux
        use 'christoomey/vim-tmux-navigator'

        -- Delete/add/change parentheses, tags etc
        use 'tpope/vim-surround'

        -- Git integration
        use 'tpope/vim-fugitive'

        -- LaTeX
        use {
            'lervag/vimtex',
            ft = { "tex" },
            config = function()
                require "plugins/vimtex"
            end
        }

        if packer_bootstrap then
            require('packer').sync()
        end
    end,
    -- Use a (very nice) floating window for packer operations
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end
        }
    }
})
