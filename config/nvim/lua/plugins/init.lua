return {
    -- Required by many plugins
    "nvim-lua/plenary.nvim",

    -- Seamless navigation between tmux and neovim
    {
        "christoomey/vim-tmux-navigator",
        keys = { "<A-h>", "<A-l>", "<A-j>", "<A-k>" },
        config = function()
            vim.g.tmux_navigator_no_mappings = 1
            vim.keymap.set("n", "<A-h>", "<cmd>TmuxNavigateLeft<CR>")
            vim.keymap.set("n", "<A-l>", "<cmd>TmuxNavigateRight<CR>")
            vim.keymap.set("n", "<A-j>", "<cmd>TmuxNavigateDown<CR>")
            vim.keymap.set("n", "<A-k>", "<cmd>TmuxNavigateUp<CR>")
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
