local M = {}

M.kanagawa = function()
    require("kanagawa").setup({
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        variablebuiltinStyle = { italic = true },
        specialReturn = true,
        specialException = true,
        transparent = true,
        -- Works really nice with laststatus = 3
        dimInactive = true,
        globalStatus = true,
        colors = {},
        overrides = {},
    })

    vim.cmd.colorscheme("kanagawa")
end

M.kanagawa_colors = {
    bg = "#16161D",
    fg = "#C8C093",
    gray = "#2A2A37",
    blue = "#7E9CD8",
    green = "#76946A",
    red = "#C34043",
    cyan = "#6A9589",
    magenta = "#957FB8",
    darkmagenta = "#54546D",
    yellow = "#DCA561",
    orange = "#D18616",
}

M.tokyonight = function()
    vim.g.tokyonight_style = "night"
    vim.g.tokyonight_terminal_colors = true
    vim.g.tokyonight_italic_comments = true
    vim.g.tokyonight_italic_functions = false
    vim.g.tokyonight_italic_keywords = false
    vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
    vim.g.tokyonight_dark_sidebar = true
    vim.g.tokyonight_dark_float = true
    vim.g.tokyonight_day_brightness = 0.3
    vim.g.tokyonight_transparent = true

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

return M

