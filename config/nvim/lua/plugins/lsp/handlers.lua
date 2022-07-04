local M = {}

function M.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if ok then
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
  end

  return capabilities
end

-- Let null-ls handle formatting
function M.disable_formatting(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = true
end

-- LSP specific mappings
function M.lsp_mappings(bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local map = vim.keymap.set

    -- map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    map("n", "K", function()
        return require("plugins.lsp.utils").fix_buf_hover()
    end, opts)
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gt", vim.lsp.buf.type_definition, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, opts)

    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map("x", "<leader>ca", vim.lsp.buf.range_code_action, opts)

    -- Diagnostics
    map("n", "<leader>df", function()
        vim.diagnostic.open_float({ scope = "line" })
    end, opts)

    map("n", "<leader>dq", vim.diagnostic.setqflist, opts)

    map("n", "]d", function()
        vim.diagnostic.goto_next()
        vim.diagnostic.open_float()
    end, opts)

    map("n", "<leader>dn", function()
        vim.diagnostic.goto_next()
        vim.diagnostic.open_float()
    end, opts)

    map("n", "[d", function()
        vim.diagnostic.goto_prev()
        vim.diagnostic.open_float()
    end, opts)

    map("n", "<leader>dp", function()
        vim.diagnostic.goto_prev()
        vim.diagnostic.open_float()
    end, opts)

end

-- Format on save
function M.fmt_on_save(client, bufnr)
    local augroup = vim.api.nvim_create_augroup("Formatting", { clear = true })
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    bufnr = bufnr,
                    timeout_ms = 3000,
                })
            end,
        })
    end
end

-- Highlight symbol under cursor, if supported by the server
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#highlight-symbol-under-cursor=
-- TODO: Checkout https://github.com/RRethy/vim-illuminate
function M.lsp_highlight_document(client, bufnr)
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup('lsp_document_highlight', {
            clear = true
        })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

-- Show diagnostics on a float window when you hover over a symbol
function M.popup_diagnostics_on_hover(bufnr)
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = "rounded",
                source = "always",
                prefix = " ",
                scope = "cursor",
            }
            vim.diagnostic.open_float(nil, opts)
        end,
    })
end

return M
