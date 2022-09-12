local M = {}

M.kanagawa = function()
    require("kanagawa").setup({
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = false },
        statementStyle = { bold = false },
        typeStyle = {},
        variablebuiltinStyle = { italic = false },
        specialReturn = true,
        specialException = true,
        transparent = true,
        dimInactive = false,
        globalStatus = true,
        terminalColors = true,
        colors = {},
        overrides = {},
        theme = "default",
    })

    vim.cmd.colorscheme("kanagawa")
end

M.kanagawa_colors = {
    bg = "#16161D",
    fg = "#C8C093",
    gray = "#727169",
    blue = "#7E9CD8",
    green = "#76946A",
    red = "#C34043",
    cyan = "#7FB4CA",
    magenta = "#D27E99",
    darkmagenta = "#957FB8",
    yellow = "#DCA561",
    orange = "#FFA066",
}

M.tokyonight = function()
    require("tokyonight").setup({
        style = "night",
        transparent = true,
        terminal_colors = true,
        styles = {
            comments = "italic",
            keywords = "NONE",
            functions = "NONE",
            variables = "NONE",
            sidebars = "dark",
            floats = "dark",
        },
        sidebars = { "qf", "help", "packer", "terminal" },
        hide_inactive_statusline = false,
        dim_inactive = false,
        on_highlights = function(hl, c)
            hl.MsgArea = { fg = c.fg_dark, bg = c.bg }
        end,
    })

    vim.cmd.colorscheme("tokyonight")
end

M.tokyonight_night_colors = {
    bg = "#1a1b26",
    fg = "#c0caf5",
    gray = "#565f89",
    blue = "#7E9CD8",
    green = "#9ece6a",
    red = "#f7768e",
    cyan = "#7dcfff",
    magenta = "#bb9af7",
    darkmagenta = "#9d7cd8",
    yellow = "#e0af68",
    orange = "#ff9e64",
}

M.gruvbox = function()
    vim.o.background = "dark"
    vim.g.gruvbox_material_background = "hard" -- hard, medium, soft
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_transparent_background = 1
    vim.g.gruvbox_material_foreground = "material"
    vim.g.gruvbox_material_disable_italic_comment = 0
    vim.g.gruvbox_material_enable_bold = 0
    vim.g.gruvbox_material_enable_italic = 1
    -- vim.g.gruvbox_material_diagnostic_line_highlight = 1
    vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
    vim.cmd.colorscheme("gruvbox-material")
end

M.gruvbox_colors = {
    bg = "#1d2021",
    fg = "#d4be98",
    gray = "#7c6f64",
    blue = "#7daea3",
    green = "#a9b665",
    red = "#ea6962",
    cyan = "#89b482",
    magenta = "#d3869b",
    darkmagenta = "#d3869b",
    yellow = "#d8a657",
    orange = "#e78a4e",
}

return M
