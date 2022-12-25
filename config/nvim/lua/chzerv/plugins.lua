return {
    -- Required by many plugins
    "nvim-lua/plenary.nvim",

    -- Automatically install LSP servers, tools etc
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- Colorscheme
    {
        "sainnhe/sonokai",
        lazy = false,
        config = function()
            vim.o.background = "dark"
            -- 'default', 'atlantis', 'andromeda', 'shusia', 'maia', 'espresso'
            vim.g.sonokai_style = "maia"
            vim.g.sonokai_better_performance = 1
            vim.g.sonokai_disable_italic_comment = 0
            vim.g.sonokai_enable_bold = 0
            vim.g.sonokai_enable_italic = 1
            vim.g.sonokai_transparent_background = 0
            vim.g.sonokai_diagnostic_virtual_text = "colored"
            vim.cmd.colorscheme("sonokai")
        end,
    },

    -- Git integration
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "Gdiffsplit", "Gclog", "Gedit", "Gsplit", "Gread" },
        keys = { "n", "<leader>gg" },
        config = function()
            vim.keymap.set("n", "<leader>gg", function()
                vim.cmd([[
                :tabnew | Git
                wincmd o
                ]])
            end, { noremap = true, silent = true })
        end,
    },

    -- Markdown enhancements
    {
        "preservim/vim-markdown",
        ft = "markdown",
    },

    -- Markdown preview
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },

    -- Quick fix list enhancements
    "romainl/vim-qf",

    -- Seamless navigation between tmux and neovim
    {
        "christoomey/vim-tmux-navigator",
        config = function()
            vim.g.tmux_navigator_no_mappings = 1
            vim.keymap.set("n", "<A-h>", "<cmd>TmuxNavigateLeft<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<A-l>", "<cmd>TmuxNavigateRight<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<A-j>", "<cmd>TmuxNavigateDown<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<A-k>", "<cmd>TmuxNavigateUp<CR>", { noremap = true, silent = true })
        end
    }
}
