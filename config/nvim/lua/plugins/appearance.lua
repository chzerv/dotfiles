--------------------------
-- Theme and statusline
--------------------------

require('nord').set()

require('lualine').setup {
  options = {
    theme = "nord",
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
