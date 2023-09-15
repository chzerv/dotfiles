return {
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        enabled = false,
        config = function()
            require("onedark").setup({
                style = "darker",
            })
            require("onedark").load()
        end,
    },

    {
        "sainnhe/gruvbox-material",
        lazy = false,
        enabled = true,
        priority = 1000,
        config = function()
            vim.o.background = "dark"
            vim.g.gruvbox_material_background = "hard"
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_disable_italic_comment = 0
            vim.g.gruvbox_material_enable_bold = 0
            vim.g.gruvbox_material_enable_italic = 1
            vim.g.gruvbox_material_transparent_background = 0
            vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
            vim.cmd.colorscheme("gruvbox-material")
        end,
    },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        enabled = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
                light_style = "day",
                transparent = false,
                terminal_colors = true,
                styles = {
                    comments = { italic = true },
                    keywords = { italic = false },
                    functions = {},
                    variables = {},
                    sidebars = "dark",
                    floats = "dark",
                },
                sidebars = { "qf", "help" },
                day_brightness = 0.3,
                hide_inactive_statusline = false,
                dim_inactive = true,
                lualine_bold = false,
            })

            vim.cmd.colorscheme("tokyonight")
        end,
    },
}
