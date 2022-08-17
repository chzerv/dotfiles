local M = {}

function M.capabilities()
    -- To get a list of a server's supported capabilities:
    -- :lua =vim.lsp.get_active_clients()[1].server_capabilities
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
function M.lsp_mappings(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local map = vim.keymap.set

    if client.name == "rust_analyzer" then
        map("n", "K", "<cmd>lua require'rust-tools'.hover_actions.hover_actions()<CR>", opts)
        map("n", "<leader>ca", "<cmd>lua require'rust-tools'.code_action_group.code_action_group<CR>", opts)
    else
        map("n", "K", function()
            return require("plugins.lsp.utils").fix_buf_hover()
        end, opts)
        map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        map("x", "<leader>ca", vim.lsp.buf.range_code_action, opts)
    end

    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gt", vim.lsp.buf.type_definition, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, opts)

    map("n", "<leader>cr", vim.lsp.buf.rename, opts)
    -- Diagnostics
    map("n", "<leader>df", function()
        vim.diagnostic.open_float({ scope = "line" })
    end, opts)

    map("n", "<leader>dq", vim.diagnostic.setqflist, opts)

    map("n", "<leader>dt", "<cmd>Telescope diagnostics theme=ivy<cr>", opts)

    map("n", "]d", function()
        vim.diagnostic.goto_next({ float = { border = "rounded" } })
    end, opts)

    map("n", "<leader>dn", function()
        vim.diagnostic.goto_next({ float = { border = "rounded" } })
    end, opts)

    map("n", "[d", function()
        vim.diagnostic.goto_prev({ float = { border = "rounded" } })
    end, opts)

    map("n", "<leader>dp", function()
        vim.diagnostic.goto_prev({ float = { border = "rounded" } })
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
        vim.api.nvim_create_augroup("lsp_document_highlight", {
            clear = true,
        })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = "lsp_document_highlight",
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

function M.codelens(client, bufnr)
    if client.server_capabilities.codeLensProvider then
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "InsertEnter" }, {
            buffer = bufnr,
            group = vim.api.nvim_create_augroup("CODELENS", { clear = true }),
            callback = function()
                vim.lsp.codelens.refresh()
            end,
        })

        vim.keymap.set(
            "n",
            "<leader>cl",
            "<cmd>lua vim.lsp.codelens.run()<CR>",
            { noremap = true, silent = true, buffer = bufnr }
        )
    end
end

return M
