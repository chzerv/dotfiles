-- LspFormat is a command defined in lua/plugins/lsp/init.lua or null-ls.lua
local group = vim.api.nvim_create_augroup("Python", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
   group = group,
   command = "LspFormat"
})

vim.api.nvim_create_autocmd("BufWritePost", {
   group = group,
   callback = function()
       vim.opt_local.copyindent = true
   end
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
--    group = group,
--    command = "StripTrailingWhitespace"
-- })
