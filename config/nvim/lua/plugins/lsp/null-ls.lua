-------------------------------------------------------
-- Configuration for null-ls
-- https://github.com/jose-elias-alvarez/null-ls.nvim
-------------------------------------------------------

local ok, null_ls = pcall(require, "null-ls")
if not ok then
    return
end

-- The following programs must be in your $PATH:
-- yamllint, ansiblelint, black, isort, stylua, prettier
local sources = {
    -- isort and black for Python
    null_ls.builtins.formatting.isort.with({
        extra_args = { "--profile", "black" },
    }),
    null_ls.builtins.formatting.black,
    -- Enable stylua for Lua
    null_ls.builtins.formatting.stylua.with({
        -- By default, stylua uses Tabs
        args = {
            "--indent-width", "4",
            "--indent-type", "Spaces",
            "-"
        }
    }),
    -- Prettier for HTML, CSS, YAML and JSON
    null_ls.builtins.formatting.prettier.with({
        filetypes = { "html", "css", "yaml", "json" },
    }),
    -- yamllint for YAML
    null_ls.builtins.diagnostics.yamllint,
}

local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local map = vim.keymap.set
    local cmd = vim.api.nvim_buf_create_user_command

    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map("x", "<leader>ca", vim.lsp.buf.range_code_action, opts)

    -- If formatting is available, create a binding and a command for it.
    if client.server_capabilities.documentFormattingProvider then
        -- Binding
        map("n", "<leader>cf", vim.lsp.buf.format, opts)

        -- Command
        cmd(bufnr, "LspFormat", vim.lsp.buf.format, { range = false, desc = "LSP format" })
    end

    -- Same, but for range formatting
    if client.server_capabilities.documentRangeFormattingProvider then

        -- Binding
        map("x", "<leader>cf", vim.lsp.buf.range_formatting, opts)

        -- Command
        cmd(bufnr, "LspFormatRange", vim.lsp.buf.range_formatting, { range = true, desc = "LSP format range" })
    end
end

null_ls.setup({
    sources = sources,
    on_attach = on_attach,
    debug = false
})

