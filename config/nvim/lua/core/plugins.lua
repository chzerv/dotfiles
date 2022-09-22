local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end

-- Automatically run :PackerSync whenever this file is updated
vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("PackerConfig", { clear = true }),
    pattern = "plugins.lua",
    command = "source <afile> | PackerSync",
})

return require("packer").startup({
    function(use)
        use("lewis6991/impatient.nvim")
        use("wbthomason/packer.nvim")
        use("nvim-lua/plenary.nvim")

        -- Navigation
        use({
            {
                "nvim-telescope/telescope.nvim",
                config = function()
                    require("plugins.telescope")
                end,
            },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make",
                after = "telescope.nvim",
                config = function()
                    require("telescope").load_extension("fzf")
                end,
            },
            {
                "nvim-telescope/telescope-ui-select.nvim",
                after = "telescope.nvim",
                config = function()
                    require("telescope").load_extension("ui-select")
                end,
            },
        })

        use({
            "ThePrimeagen/harpoon",
            keys = {
                { "n", "<leader>ha" },
                { "n", "<leader>hh" },
                { "n", "<leader>1" },
                { "n", "<leader>2" },
                { "n", "<leader>3" },
                { "n", "<leader>4" },
            },
            config = function()
                require("plugins.harpoon")
            end,
        })

        -- LSP, completion and snippets
        use({
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        })

        use({
            "neovim/nvim-lspconfig",
            config = function()
                require("plugins.lsp")
            end,
            setup = function()
                lazy_load("nvim-lspconfig")
            end,
        })

        use({
            "simrat39/rust-tools.nvim",
            after = "nvim-lspconfig",
            ft = { "rust" },
            config = function()
                require("plugins.lsp.rust-tools")
            end,
        })

        use({
            "jose-elias-alvarez/null-ls.nvim",
            after = "nvim-lspconfig",
            config = function()
                require("plugins.lsp.null-ls")
            end,
        })

        use({
            "j-hui/fidget.nvim",
            after = "null-ls.nvim",
            config = function()
                require("plugins.lsp.fidget")
            end,
        })

        use({
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            config = function()
                require("plugins.nvim-cmp")
            end,
            requires = {
                { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
                { "hrsh7th/cmp-path", after = "nvim-cmp" },
                -- { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
                { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
                "hrsh7th/cmp-nvim-lsp",
            },
        })

        use({
            "saadparwaiz1/cmp_luasnip",
            after = "nvim-cmp",
        })

        use({
            "L3MON4D3/LuaSnip",
            config = function()
                require("plugins.luasnip")
            end,
        })

        -- Tree-sitter
        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
                require("plugins.treesitter")
            end,
        })
        use({ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" })

        use({
            "sainnhe/gruvbox-material",
            config = function()
                require("plugins.colors").gruvbox()
            end,
        })

        use({
            "feline-nvim/feline.nvim",
            config = function()
                require("plugins.feline")
            end,
            requires = {
                "kyazdani42/nvim-web-devicons",
            },
        })

        -- Editing goodies
        use({
            "kylechui/nvim-surround",
            config = function()
                require("plugins.nvim-surround")
            end,
        })

        use({
            "numToStr/Comment.nvim",
            keys = {
                { "n", "gcc" },
                { "n", "gc" },
                { "v", "gc" },
                { "v", "gb" },
            },
            config = function()
                require("plugins.comment")
            end,
        })

        use({
            "windwp/nvim-autopairs",
            event = "InsertCharPre",
            after = "nvim-cmp",
            config = function()
                require("plugins.autopairs")
            end,
        })

        use({
            "lukas-reineke/indent-blankline.nvim",
            ft = { "yaml", "python", "json", "yaml.ansible" },
            config = function()
                require("plugins.indentline")
            end,
        })

        use({
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = function()
                require("plugins.gitsigns")
            end,
        })

        -- Improve navigation inside tmux
        use({
            "christoomey/vim-tmux-navigator",
            config = function()
                vim.g.tmux_navigator_no_mappings = 1
                vim.keymap.set("n", "<A-h>", "<cmd>TmuxNavigateLeft<CR>", { noremap = true, silent = true })
                vim.keymap.set("n", "<A-l>", "<cmd>TmuxNavigateRight<CR>", { noremap = true, silent = true })
                vim.keymap.set("n", "<A-j>", "<cmd>TmuxNavigateDown<CR>", { noremap = true, silent = true })
                vim.keymap.set("n", "<A-k>", "<cmd>TmuxNavigateUp<CR>", { noremap = true, silent = true })
            end,
        })

        -- Improvements to the quickfix/location windows
        -- TODO: https://github.com/kevinhwang91/nvim-bqf
        use("romainl/vim-qf")

        -- LaTeX
        use({
            "lervag/vimtex",
            ft = { "tex" },
            config = function()
                require("plugins.vimtex")
            end,
        })

        use({
            ft = { "markdown" },
            "iamcco/markdown-preview.nvim",
            run = function()
                vim.fn["mkdp#util#install"]()
            end,
        })

        use({
            "preservim/vim-markdown",
            ft = { "markdown" },
        })

        if packer_bootstrap then
            require("packer").sync()
        end
    end,
    config = {
        max_jobs = 50,
        auto_clean = true,
        compile_on_sync = true,
    },
})
