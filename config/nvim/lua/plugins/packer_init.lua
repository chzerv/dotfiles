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

        use 'nvim-lua/plenary.nvim'

        -- Improve startup time with caching
        use 'lewis6991/impatient.nvim'

    -- Telescope {{{

        use ({
            {
                'nvim-telescope/telescope.nvim',
                config = function()
                    require('plugins/nvim-telescope')
                end,
            },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                run = 'make',
                after = 'telescope.nvim',
                config = function()
                    require('telescope').load_extension('fzf')
                end,
            },
            {
                'crispgm/telescope-heading.nvim',
                ft = { 'tex', 'markdown' },
                config = function()
                    require('telescope').load_extension('heading')
                    vim.api.nvim_set_keymap('n', '<localleader>H', [[<Cmd>Telescope heading<CR>]], { noremap = true, silent = true })
                end,
            }
        })

    -- }}}

    -- Editing {{{

        use 'andymass/vim-matchup'

        use 'tpope/vim-surround'

        use {
            'tpope/vim-fugitive',
            config = function()
                vim.keymap.set('n', '<leader>gg', function()
                vim.cmd([[
                    :tabnew | Git
                    wincmd o
                ]])
                end, { noremap = true, silent = true })
            end
        }

        use {
            'numToStr/Comment.nvim',
            config = function()
                require('plugins/nvim-comment')
            end
        }

        use {
            'windwp/nvim-autopairs',
            after = 'nvim-cmp',
            config = function()
                require('plugins/nvim-autopairs')
            end
        }

        use {
            'lukas-reineke/indent-blankline.nvim',
            ft = { 'yaml', 'python', 'json' },
            config = function()
                require('plugins/nvim-indent-blankline')
            end
        }

    -- }}}

    -- Tree sitter {{{

        use ({
            {
                'nvim-treesitter/nvim-treesitter',
                run = ':TSUpdate',
                config = function()
                    require('plugins/nvim-treesitter')
                end,
            },
            { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
            { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' },
        })

    -- }}}

    -- Completion, LSP and snippets {{{

        use {
            'williamboman/nvim-lsp-installer',
            {
                'neovim/nvim-lspconfig',
                config = function()
                    require('plugins/nvim-lsp')
                end,
            }
        }

        use {
            'hrsh7th/nvim-cmp',
            config = function()
                require('plugins/nvim-cmp')
            end
        }
        use 'hrsh7th/cmp-nvim-lsp'
        use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
        use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
        use 'hrsh7th/cmp-nvim-lsp-signature-help'
        use 'hrsh7th/cmp-nvim-lua'
        use 'onsails/lspkind.nvim'
        use { 
            'L3MON4D3/LuaSnip',
            config = function()
                require('plugins/nvim-luasnip')
            end
        }
        use 'saadparwaiz1/cmp_luasnip'

    -- }}}

    -- Appearance {{{
        use 'shaunsingh/nord.nvim'
        use {
            'nvim-lualine/lualine.nvim',
            -- requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }
    -- }}}

        -- Improve navigation inside tmux
        use { 
            'christoomey/vim-tmux-navigator',
            config = function()
                vim.g.tmux_navigator_no_mappings = 1
            end
        }

        -- LaTeX
        use {
            'lervag/vimtex',
            ft = { 'tex' },
            config = function()
                require 'plugins/vimtex'
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
