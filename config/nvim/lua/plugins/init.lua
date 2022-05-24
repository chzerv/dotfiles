-----------------------------------------------
-- Initialize packer and install plugins
-- https://github.com/wbthomason/packer.nvim
-----------------------------------------------

-- Automatically install packer
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(nvim_path)) > 0 then
    fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    execute("packadd packer.nvim")
end

-- Run :PackerCompile whenever this file is updated
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PackerConfig', { clear = true }),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile',
})

require("packer").init {
    max_jobs = 50,
    auto_clean = true,
    compile_on_sync = true,
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'single' })
        end,
    },
}

return require("packer").startup(function(use)

    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'lewis6991/impatient.nvim'

   -- UI
    use { "rebelot/kanagawa.nvim",
        config = function()
            require "plugins.kanagawa"
        end
    }

    use {
        "nvim-lualine/lualine.nvim",
        after = "kanagawa.nvim",
        event = "VimEnter",
        config = function()
            require "plugins.lualine"
        end
    }

    -- Tree-sitter
    use ({
        {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config = function()
                require "plugins.treesitter"
            end,
        },
        { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
        -- { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' },
    })

    -- Completion, LSP and Snippets
    use {
        'williamboman/nvim-lsp-installer',
        {
            'neovim/nvim-lspconfig',
            config = function()
                require "plugins.lsp"
            end,
        }
    }

    use({
        "jose-elias-alvarez/null-ls.nvim",
        after = "nvim-lspconfig",
        config = function()
            require "plugins.lsp.null-ls"
        end,
    })

    use {
        'hrsh7th/nvim-cmp',
        config = function()
            require "plugins.nvim-cmp"
        end,
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "onsails/lspkind.nvim",
        },
    }
    use {
        'L3MON4D3/LuaSnip',
        after = "nvim-cmp",
        config = function()
            require "plugins.luasnip"
        end
    }
    use {
        'saadparwaiz1/cmp_luasnip',
        after = "LuaSnip"
    }

    -- Editing
    use {
        'andymass/vim-matchup',
    }

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

    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("plugins.gitsigns")
        end,
        event = "BufEnter",
    })

    use {
        "rhysd/git-messenger.vim",
        event = "BufRead",
        config = function()
            require "plugins.git-messenger"
        end
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require "plugins.comment"
        end
    }

    use {
        'windwp/nvim-autopairs',
        event = "InsertCharPre",
        after = 'nvim-cmp',
        config = function()
            require "plugins.autopairs"
        end
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        ft = { 'yaml', 'python', 'json' },
        config = function()
            require "plugins.indentline"
        end
    }

    use ({
        {
            'nvim-telescope/telescope.nvim',
            event = "CursorHold",
            config = function()
                require "plugins.telescope"
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


    -- Improve navigation inside tmux
    use {
        'christoomey/vim-tmux-navigator',
        config = function()
            vim.g.tmux_navigator_no_mappings = 1
            vim.keymap.set('n', '<A-h>', "<cmd>TmuxNavigateLeft<CR>", { noremap = true, silent = true})
            vim.keymap.set('n', '<A-l>', "<cmd>TmuxNavigateRight<CR>", { noremap = true, silent = true})
            vim.keymap.set('n', '<A-j>', "<cmd>TmuxNavigateDown<CR>", { noremap = true, silent = true})
            vim.keymap.set('n', '<A-k>', "<cmd>TmuxNavigateUp<CR>", { noremap = true, silent = true})
        end
    }

    -- LaTeX
    use {
        'lervag/vimtex',
        ft = { 'tex' },
        config = function()
            require "plugins.vimtex"
        end
    }
end)
