local vi_mode = require("feline.providers.vi_mode")
local lsp = require("feline.providers.lsp")
local colors = require("plugins.colors").tokyonight_night_colors

-- Change the default mode colors
local vi_mode_colors = {
    NORMAL = colors.green,
    INSERT = colors.magenta,
    VISUAL = colors.darkmagenta,
    OP = colors.green,
    BLOCK = colors.blue,
    REPLACE = colors.magenta,
    ["V-REPLACE"] = colors.magenta,
    ENTER = colors.cyan,
    MORE = colors.cyan,
    SELECT = colors.orange,
    COMMAND = colors.yellow,
    SHELL = colors.yellow,
    TERM = colors.yellow,
    NONE = colors.red,
}

local components = { active = {}, inactive = {} }

-- Active statusline
components.active[1] = {
    {
        provider = "▊",
        hl = function()
            return {
                fg = vi_mode.get_mode_color(),
                bg = colors.bg,
            }
        end,
    },
    {
        provider = {
            name = "file_info",
            opts = {
                colored_icon = true,
                file_modified_icon = "± ",
                hl = { fg = colors.cyan },
            },
        },
        right_sep = " ",
        left_sep = " ",
    },

    {
        provider = "> ",
        hl = { fg = "bg" },
    },
}

components.active[2] = {
    {
        provider = "diagnostic_errors",
        hl = { fg = colors.red },
    },
    {
        provider = "diagnostic_warnings",
        hl = { fg = colors.yellow },
    },
    {
        provider = "diagnostic_hints",
        hl = { fg = colors.cyan },
    },
    {
        provider = "diagnostic_info",
        hl = { fg = colors.blue },
    },
    {
        enabled = function()
            return lsp.diagnostics_exist()
        end,
        right_sep = { str = " ", always_visible = true },
    },
    {
        provider = "git_branch",
        left_sep = " ",
        right_sep = " ",
    },
    {
        provider = "git_diff_added",
        hl = { fg = colors.green },
    },
    {
        provider = "git_diff_changed",
        hl = { fg = colors.orange },
    },
    {
        provider = "git_diff_removed",
        hl = { fg = colors.red },
        right_sep = " ",
    },
    {
        provider = "position",
        left_sep = " ",
    },
    {
        provider = "scroll_bar",
        left_sep = " ",
        hl = {
            fg = colors.green,
        },
    },
}

-- Setup feline.nvim
require("feline").setup({
    components = components,
    vi_mode_colors = vi_mode_colors,
    theme = {
        bg = colors.bg,
        fg = colors.fg,
    },
    custom_providers = {
        -- https://github.com/feline-nvim/feline.nvim/blob/2962c8c4a67f41ef35c58aa367ff2afb7a9691d3/lua/feline/providers/lsp.lua#L18-L26
        my_lsp_client_names = function()
            local clients = {}

            for _, client in pairs(vim.lsp.buf_get_clients(0)) do
                clients[#clients + 1] = client.name
            end

            return table.concat(clients, " + "), "   LSP: "
        end,
    },
})

local winbar_components = {
    active = {
        {
            {
                provider = {
                    name = "file_info",
                    opts = {
                        colored_icon = true,
                        file_modified_icon = "± ",
                        hl = { fg = colors.cyan },
                    },
                },
            },
        },
    },

    inactive = {
        {
            {
                provider = {
                    name = "file_info",
                    opts = {
                        colored_icon = true,
                        file_modified_icon = "± ",
                        hl = { fg = colors.cyan },
                    },
                },
            },
        },
    },
}

-- Setup feline.nvim winbar
require("feline").winbar.setup({
    components = winbar_components,
})
