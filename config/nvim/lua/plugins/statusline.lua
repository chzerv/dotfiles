local api = vim.api
local vi_mode = require("feline.providers.vi_mode")
local lsp = require("feline.providers.lsp")
local gps = require("nvim-gps")
local opt = vim.opt

opt.laststatus = 3 -- Global status line
opt.winbar = "=%=%m %t" -- (Requires nvim nightly)

gps.setup()

-- Change the default mode colors
local vi_mode_colors = {
    NORMAL = "green",
    INSERT = "purple",
    VISUAL = "darkpurple",
    OP = "green",
    BLOCK = "blue",
    REPLACE = "purple",
    ["V-REPLACE"] = "purple",
    ENTER = "cyan",
    MORE = "cyan",
    SELECT = "orange",
    COMMAND = "yellow",
    SHELL = "green",
    TERM = "green",
    NONE = "yellow",
}

local components = { active = {}, inactive = {} }

-- Active statusline
components.active[1] = {
    {
        provider = "▊",
        hl = function()
            return {
                fg = vi_mode.get_mode_color(),
                bg = "bg",
            }
        end,
    },
    {
        provider = {
            name = "file_info",
            opts = {
                type = "unique",
                colored_icon = true,
            },
        },
        right_sep = " ",
        left_sep = " ",
    },
    {
        provider = "> ",
        hl = { fg = "bg" },
    },
    {
        enabled = function()
            return gps.is_available()
        end,
        provider = function()
            return gps.get_location()
        end,
        hl = {
            fg = "cyan",
        },
    },
}

components.active[2] = {
    {
        provider = "diagnostic_errors",
        hl = { fg = "red" },
    },
    {
        provider = "diagnostic_warnings",
        hl = { fg = "yellow" },
    },
    {
        provider = "diagnostic_hints",
        hl = { fg = "cyan" },
    },
    {
        provider = "diagnostic_info",
        hl = { fg = "blue" },
    },
    {
        enabled = function()
            return lsp.diagnostics_exist()
        end,
        right_sep = { str = " ", always_visible = true },
    },
    {
        enabled = function()
            return vim.bo.filetype ~= ""
        end,
        provider = {
            name = "file_type",
            opts = {
                case = "titlecase",
                filetype_icon = true,
                colored_icon = true,
            },
        },
        left_sep = " ",
        right_sep = " ",
    },
    {
        provider = "git_branch",
        left_sep = " ",
        right_sep = " ",
    },
    -- { provider = "line_percentage" },
    { provider = "lines_cols_pos" },
    {
        provider = "scroll_bar",
        left_sep = " ",
        hl = {
            fg = "green",
        },
    },
}

-- Setup feline.nvim
require("feline").setup({
    theme = {
        bg = "#16161D",
        fg = "#C8C093",
        lightgray = "#363646",
        gray = "#2A2A37",
        blue = "#7E9CD8",
        green = "#76946A",
        red = "#C34043",
        cyan = "#6A9589",
        purple = "#957FB8",
        darkpurple = "#54546D",
        yellow = "#DCA561",
    },
    components = components,
    vi_mode_colors = vi_mode_colors,
    custom_providers = {
        lines_cols_pos = function()
            local line, col = unpack(api.nvim_win_get_cursor(0))
            col = vim.str_utfindex(api.nvim_get_current_line(), col) + 1

            return string.format("%d:%d", line, col)
        end,
    },
})

local winbar_components = {
    active = {
        {
            {
                provider = "file_info",
                hl = {
                    fg = "skyblue",
                    bg = "NONE",
                    style = "bold",
                },
            },
        },
    },
}

-- Setup feline.nvim winbar
require("feline").winbar.setup({
    components = winbar_components,
})

require("fidget").setup({
    text = {
        spinner = "moon",
    },
    align = {
        bottom = true,
    },
    window = {
        relative = "editor",
    },
})
