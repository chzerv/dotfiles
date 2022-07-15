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
                "crispgm/telescope-heading.nvim",
                ft = { "tex", "markdown" },
                after = "telescope.nvim",
                config = function()
                    require("telescope").load_extension("heading")
                    vim.api.nvim_set_keymap(
                        "n",
                        "<localleader>H",
                        [[<Cmd>Telescope heading<CR>]],
                        { noremap = true, silent = true }
                    )
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
            },
            config = function()
                require("plugins.harpoon")
            end,
        })

        -- LSP, completion and snippets
        use({
            "williamboman/nvim-lsp-installer",
            cmd = {
                "LspInstall",
                "LspInstallInfo",
                "LspPrintInstalled",
                "LspRestart",
                "LspStart",
                "LspStop",
                "LspUninstall",
                "LspUninstallAll",
            },
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
            "jose-elias-alvarez/null-ls.nvim",
            after = "nvim-lspconfig",
            config = function()
                require("plugins.lsp.null-ls")
            end,
        })

        use({
            "j-hui/fidget.nvim",
            after = "nvim-lspconfig",
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
            "L3MON4D3/LuaSnip",
            after = "nvim-cmp",
            config = function()
                require("plugins.luasnip")
            end,
        })

        use({
            "saadparwaiz1/cmp_luasnip",
            after = "LuaSnip",
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

        -- UI
        use({
            "rebelot/kanagawa.nvim",
            config = function()
                require("plugins.colors").kanagawa()
            end,
        })

        use({
            "feline-nvim/feline.nvim",
            config = function()
                require("plugins.statusline")
            end,
            requires = {
                "kyazdani42/nvim-web-devicons",
                opt = true,
            },
        })

        -- Editing goodies
        use({
            "kylechui/nvim-surround",
            config = function()
                require("plugins.nvim-surround")
            end
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

        -- Git integration
        use({
            "tpope/vim-fugitive",
            cmd = { "Git", "Gdiffsplit", "Gclog" },
            keys = { "n", "<leader>gg" },
            config = function()
                vim.keymap.set("n", "<leader>gg", function()
                    vim.cmd([[
                    :tabnew | Git
                    wincmd o
                    ]])
                end, { noremap = true, silent = true })
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

        -- Delete buffers without messing up the window layout
        use({
            "famiu/bufdelete.nvim",
            setup = function()
                lazy_load("bufdelete.nvim")
            end,
            config = function()
                require("plugins.bufdelete")
            end,
        })

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
            run = function() vim.fn["mkdp#util#install"]() end,
        })

        use({
            "numToStr/FTerm.nvim",
            event = "CursorHold",
            config = function()
                require("plugins.fterm")
            end,
        })

        if packer_bootstrap then
            require("packer").sync()
        end
    end,
    config = {
        max_jobs = 50,
        auto_clean = true,
        compile_on_sync = true,
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "single" })
            end,
        },
    },
})
