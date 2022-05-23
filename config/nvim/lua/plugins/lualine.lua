-----------------------------------------------------
-- Configuration for lualine
-- https://github.com/nvim-lualine/lualine.nvim
-----------------------------------------------------

require('lualine').setup {
    options = {
        theme = "auto",
        icons_enabled = false,
        section_separators = "",
        component_separators = "",
        always_divide_middle = true,
        globalstatus = true
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'diagnostics' },
        lualine_z = { 'location' },
    },
}
