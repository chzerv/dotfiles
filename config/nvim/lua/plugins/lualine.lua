local M = {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
}

function M.config()
    -- Bubbles config for lualine
    -- Author: lokesh-krishna
    -- MIT license, see LICENSE for more details.

    require("lualine").setup({
        options = {
            theme = "auto",
            icons_enabled = true,
            globalstatus = true,
            component_separators = "|",
            section_separators = { left = "", right = "" },
        },
        sections = {
            lualine_a = {
                { "mode", separator = { left = "" }, right_padding = 2 },
            },
            lualine_b = { "branch", "diff" },
            lualine_c = {
                { "filename", path = 1, symbols = { modified = " ± ", readonly = "", unnamed = "" } },
            },
            lualine_x = {},
            lualine_y = {
                { "diagnostics", sources = { "nvim_diagnostic" } },
            },
            lualine_z = {
                { "location", separator = { right = "" }, left_padding = 2 },
            },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
    })
end

return M
