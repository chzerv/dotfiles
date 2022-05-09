----------------------------------
-- Configuration for neovim-lsp
----------------------------------

local cmp = require('cmp')
local lspconfig = require('lspconfig')

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  -- vim.keymap.set('n', '<leader>wl', function()
  --   vim.inspect(vim.lsp.buf.list_workspace_folders())
  -- end, opts)
  -- vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  -- vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
  -- vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})

  -- Use telescope.nvim
  vim.keymap.set('n', 'gd', [[<Cmd>lua Telescope lsp_definitions<CR>]], opts)
  vim.keymap.set('n', 'gr', [[<Cmd>lua Telescope lsp_references<CR>]], opts)
  vim.keymap.set('n', 'gi', [[<Cmd>lua Telescope lsp_implementations<CR>]], opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
end

-- nvim-cmp
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()) --nvim-cmp

capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }

-- Setup LSP servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'bashls', 'yamlls', 'ansiblels', 'sumneko_lua'}

-- Automatically install LSP servers using nvim-lsp-installer
-- https://github.com/williamboman/nvim-lsp-installer
require('nvim-lsp-installer').setup {
  ensure_installed = servers
}

for _, server in ipairs(servers) do 
  lspconfig[server].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

