-- [Test] Use filetype.lua instead of filetype.vim for performance
vim.g.did_load_filetypes = 0
vim.g.do_filetype_lua = 1

-- Disable builtin plugins
local builtin_plugins = {
    loaded_gzip              = 1,
    loaded_zip               = 1,
    loaded_zipPlugin         = 1,
    loaded_tar               = 1,
    loaded_tarPlugin         = 1,
    loaded_getscript         = 1,
    loaded_getscriptPlugin   = 1,
    loaded_vimball           = 1,
    loaded_vimballPlugin     = 1,
    loaded_2html_plugin      = 1,
    loaded_matchit           = 1,
    loaded_matchparen        = 1,
    loaded_logiPat           = 1,
    loaded_rrhelper          = 1,
    loaded_netrw             = 1,
    loaded_netrwPlugin       = 1,
    loaded_netrwSettings     = 1,
    loaded_tutor_mode_plugin = 1,
    loaded_rplugin           = 1,
    loaded_bugreport         = 1,
    loaded_syntax            = 1,
}

for k, v in pairs(builtin_plugins) do
    vim.g[k] = v
end
