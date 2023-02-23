return {
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        enabled = true,
        config = function()
            require("onedark").setup({
                style = "darker",
            })
            require("onedark").load()
        end,
    },

    {
        "sainnhe/sonokai",
        lazy = false,
        enabled = false,
        priority = 1000,
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
    {
        "bluz71/vim-moonfly-colors",
        lazy = false,
        enabled = false,
        priority = 1000,
        config = function()
            vim.g.moonflyCursorColor = true
            vim.g.moonflyItalics = true
            vim.g.moonflyVirtualTextColor = false
            vim.cmd.colorscheme("moonfly")
        end,
    },
}
