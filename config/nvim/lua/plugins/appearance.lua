--------------------------
-- Theme and statusline
--------------------------

-- require('onedark').setup {
--     style = 'darker'
-- }
-- require('onedark').load()

require('nord').set()

require('lualine').setup {
  options = {
    theme = 'nord',
    icons_enabled = false,
    section_separators = '',
    component_separators = ''
  },
  sections = {
      lualine_x = {
          'filetype'
      }
  }
}
