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
    -- isort and black for Python
    formatting.isort.with({
        extra_args = { "--profile", "black" },
    }),

    formatting.black,

    -- stylua for Lua
    formatting.stylua.with({
        -- By default, stylua uses Tabs
        args = {
            "--indent-width",
            "4",
            "--indent-type",
            "Spaces",
            "-",
        },
    }),

    -- Prettier for HTML, CSS, YAML and JSON
    formatting.prettier.with({
        filetypes = { "html", "css", "yaml", "json", "yaml", "markdown", "graphql", "typescript", "javascript" },
    }),

    -- yamllint for YAML
    diagnostics.yamllint,

    -- ansible-lint for Ansible
    diagnostics.ansiblelint,

    formatting.gofmt,
    formatting.rustfmt,
}

local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local map = vim.keymap.set

    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    -- If formatting is available, create a binding and a command for it.
    if client.server_capabilities.documentFormattingProvider then
        map("n", "<leader>cf", vim.lsp.buf.format, opts)
    end
end

null_ls.setup({
    sources = sources,
    on_attach = on_attach,
    debug = false,
})
