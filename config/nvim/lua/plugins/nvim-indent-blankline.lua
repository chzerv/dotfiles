-------------------------------------------------------------
-- Configuration for indent-blankline.nvim
-- https://github.com/lukas-reineke/indent-blankline.nvim
-------------------------------------------------------------

local ok, indent_blankline = pcall(require, 'indent_blankline')
if not ok then
    return
end

indent_blankline.setup {
  use_treesitter = true,
  show_first_indent_level = false,
  show_trailing_blankline_indent = false,
  filetype = {
      'py',
      'yaml',
      'yml',
      'json',
  },
  -- filetype_exclude = {
  --     'lua',
  -- },
  buftype_exclude = {
    'terminal',
    'nofile',
    'quickfix',
  },
}
