local M = {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
}

local function clock()
    return " " .. os.date("%H:%M")
end

function M.config()
    require("lualine").setup({
        options = {
            theme = "auto",
            section_separators = { left = "", right = "" },
            component_separators = { left = "", right = "" },
            icons_enabled = true,
            globalstatus = true,
            disabled_filetypes = { statusline = { "dashboard" } },
        },
        sections = {
            lualine_a = { { "mode", separator = { left = "" } } },
            lualine_b = { "branch" },
            lualine_c = {
                { "diagnostics", sources = { "nvim_diagnostic" } },
                { "filename", path = 1, symbols = { modified = " ± ", readonly = "", unnamed = "" } },
            },
            lualine_x = {},
            lualine_y = { "location" },
            lualine_z = { { clock, separator = { right = "" } } },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        -- winbar = {
        --   lualine_a = {},
        --   lualine_b = {},
        --   lualine_c = { "filename" },
        --   lualine_x = {},
        --   lualine_y = {},
        --   lualine_z = {},
        -- },
        --
        -- inactive_winbar = {
        --   lualine_a = {},
        --   lualine_b = {},
        --   lualine_c = { "filename" },
        --   lualine_x = {},
        --   lualine_y = {},
        --   lualine_z = {},
        -- },
    })
end

return M
