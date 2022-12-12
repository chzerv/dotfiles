-------------------------------------------------------
-- Configuration for null-ls
-- https://github.com/jose-elias-alvarez/null-ls.nvim
-------------------------------------------------------

local ok, null_ls = pcall(require, "null-ls")
if not ok then
    return
end

local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

-- The following programs must be in your $PATH:
-- yamllint, ansiblelint, black, isort, stylua, prettier
local sources = {
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
}

local on_attach = function(client, bufnr)
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

null_ls.setup({
    sources = sources,
    on_attach = on_attach,
    debug = false,
})
