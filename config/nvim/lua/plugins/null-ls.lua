-------------------------------------------------------
-- Configuration for null-ls
-- https://github.com/jose-elias-alvarez/null-ls.nvim
-------------------------------------------------------

local M = {
    "jose-elias-alvarez/null-ls.nvim",
}

function M.setup()
    local nls = require("null-ls")

    local diagnostics = nls.builtins.diagnostics
    local formatting = nls.builtins.formatting

    nls.setup({
        debug = false,
        debounce = 150,
        sources = {
            formatting.black,
            formatting.stylua.with({
                extra_args = {
                    "--quote-style", "AlwaysPreferDouble",
                    "--indent-width", "4",
                    "--indent-type", "Spaces",
                },
            }),
            formatting.prettier.with({
                filetypes = { "html", "css", "yaml", "json", "yaml", "markdown", "graphql", "typescript", "javascript" },
            }),
            diagnostics.yamllint,
            diagnostics.ansiblelint,
            formatting.gofmt,
            formatting.rustfmt,
        },

        on_attach = function(client, bufnr)
            local opts = { noremap = true, silent = true, buffer = bufnr }
            local map = vim.keymap.set

            map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

            if client.server_capabilities.documentFormattingProvider then
                map("n", "<leader>cf", vim.lsp.buf.format, opts)
            end

            if client.server_capabilities.documentRangeFormattingProvider then
                map("v", "<leader>cf", vim.lsp.buf.format)
            end
        end
    })

end

return M
