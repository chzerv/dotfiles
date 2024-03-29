return {
    "lukas-reineke/indent-blankline.nvim",
    ft = { "yaml", "python", "json", "yaml.ansible" },
    config = function()
        require("indent_blankline").setup({
            use_treesitter = true,
            show_first_indent_level = false,
            show_trailing_blankline_indent = false,
            buftype_exclude = {
                "terminal",
                "nofile",
                "quickfix",
            },
            filetype_exclude = {
                "help",
            },
        })
    end,
}
