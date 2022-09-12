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
        theme = "default"
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
            hl.MsgArea = { fg = c.fg_dark, bg=c.bg }
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

return M
