-- Install servers
local servers = {
    "gopls",
    "yamlls",
    "jsonls",
    "pyright",
    "sumneko_lua",
    "dockerls",
    "emmet_ls",
    "terraformls",
    "texlab",
    "ansiblels",
    "bashls",
}

local has_mason, mason = pcall(require, "mason")
if not has_mason then
    return
end

mason.setup()

local has_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if not has_mason_lspconfig then
    return
end

mason_lspconfig.setup({
    ensure_installed = servers,
})

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
    return
end

local handlers_ok, handlers = pcall(require, "plugins.lsp.handlers")
if not handlers_ok then
    return
end

-- Override handlers
vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", silent = true, max_height = 20 })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = "rounded", silent = true, max_height = 20, relative = "cursor" }
)

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, server in ipairs(servers) do
    local opts = {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            handlers.lsp_mappings(client, bufnr)
            -- handlers.popup_diagnostics_on_hover(bufnr)
            -- handlers.lsp_highlight_document(client, bufnr)
            -- handlers.fmt_on_save(client, bufnr)
        end,
    }

    -- If there is a custom configuration for a server...
    local has_custom_opts, custom_opts = pcall(require, "plugins.lsp.servers." .. server)

    if has_custom_opts then
        opts = vim.tbl_deep_extend("force", custom_opts, opts)
    end

    lspconfig[server].setup(opts)
end

-- Setup diagnostics
require("plugins.lsp.diagnostics").setup()
