------------------------------------------------
-- Configuration for nvim-autopairs
-- https://github.com/windwp/nvim-autopairs
------------------------------------------------

local ok, autopairs = pcall(require, 'nvim-autopairs')
if not ok then
    return
end

autopairs.setup({
    enable_check_bracket_line = true,
    disable_filetype = { 'TelescopePrompt' },
})
