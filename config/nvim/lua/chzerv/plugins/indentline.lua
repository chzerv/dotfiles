local M = {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    -- event = "VeryLazy",
    ft = { "yaml", "python", "json", "yaml.ansible" },
}

function M.config()
    local indent = require("indent_blankline")
    indent.setup({
        use_treesitter = true,
        show_first_indent_level = false,
        show_trailing_blankline_indent = false,
        buftype_exclude = {
            'terminal',
            'nofile',
            'quickfix',
        },
        filetype_exclude = {
            "help",
        },
    })
end

return M
