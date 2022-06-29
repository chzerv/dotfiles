local vi_mode = require("feline.providers.vi_mode")
local lsp = require("feline.providers.lsp")

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
                colored_icon = true,
                file_modified_icon = "± ",
                hl = { fg = "cyan" },
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
        provider = "git_branch",
        left_sep = " ",
        right_sep = " ",
    },
    {
        provider = "git_diff_added",
        hl = { fg = "green" },
    },
    {
        provider = "git_diff_changed",
        hl = { fg = "orange" },
    },
    {
        provider = "git_diff_removed",
        hl = { fg = "red" },
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
        active_lsp_client = function()
            for _, client in ipairs(vim.lsp.get_active_clients()) do
                if client.attached_buffers[vim.api.nvim_get_current_buf()] then
                    return (vim.o.columns > 60 and "%#St_LspStatus#" .. "  LSP ~ " .. client.name .. " ")
                        or "  LSP "
                end
            end
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
                        type = "unique",
                        colored_icon = true,
                        file_modified_icon = "± ",
                        hl = { fg = "cyan" },
                    },
                },
            },
        },
    },
}

-- Setup feline.nvim winbar
require("feline").winbar.setup({
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
    components = winbar_components,
})
