-------------------------------------------------------------
-- Configuration for indent-blankline.nvim
-- https://github.com/lukas-reineke/indent-blankline.nvim
-------------------------------------------------------------

local ok, inli = pcall(require, 'indent_blankline')
if not ok then
    return
end

inli.setup {
    ft = { 'py', 'yaml', 'yml', 'json'}
}
