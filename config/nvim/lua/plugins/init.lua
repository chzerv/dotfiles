return {
    -- Required by many plugins
    "nvim-lua/plenary.nvim",

    -- Seamless navigation between tmux and neovim
    {
        "christoomey/vim-tmux-navigator",
        keys = {
            { "<A-h>", "<cmd>TmuxNavigateLeft<CR>" },
            { "<A-l>", "<cmd>TmuxNavigateRight<CR>" },
            { "<A-j>", "<cmd>TmuxNavigateDown<CR>" },
            { "<A-k>", "<cmd>TmuxNavigateUp<CR>" },
        },
        config = function()
            vim.g.tmux_navigator_no_mappings = 1
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
}
