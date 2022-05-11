---------------------------------------------------------
-- LSP Configuration using lspconfig.
-- Server installation is handled by lsp-installer.
---------------------------------------------------------

-- Install LSP servers
local ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not ok then
    return
end

local servers = { "pyright", "ansiblels", "yamlls", "bashls", "dockerls", "jsonls" }

lsp_installer.setup {
    ensure_installed = servers,
    automatic_installation = true,
}

-- Configure LSP
local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
    return
end

local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status_ok then
    return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local on_attach = function()
    local opts = { buffer = 0 }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>cdn", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<leader>cdp", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<leader>cdl", "<cmd>Telescope diagnostics<CR>", opts)
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set({"n", "i"}, "<C-k>", vim.lsp.buf.signature_help, opts)
    end

for _, server in ipairs(servers) do
    lspconfig[server].setup {
        on_attach = on_attach,
        capabilities =capabilities
    }
end
