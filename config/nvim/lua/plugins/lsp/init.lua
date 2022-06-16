---------------------------------------------------------
-- LSP Configuration using lspconfig.
-- Server installation is handled by nvim-lsp-installer
---------------------------------------------------------

require("plugins.lsp.diagnostics").setup()
local utils = require("plugins.lsp.utils")

-- Install LSP servers

local servers = {
    "pyright",
    "ansiblels",
    "yamlls",
    "bashls",
    "dockerls",
    "jsonls",
    "sumneko_lua",
    "rust_analyzer",
    "gopls",
}

local ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if ok then
    lsp_installer.setup({
        ensure_installed = servers,
        automatic_installation = true,
        ui = {
            icons = {
                server_installed = "✓",
                server_pending = "➜",
                server_uninstalled = "✗",
            },
        },
    })
end

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
    return
end

local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_ok then
    return
end

-- Override handlers
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = "rounded", silent = true, max_height = 10 }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = "rounded", silent = true, max_height = 10 }
)

-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local map = vim.keymap.set
    local cmd = vim.api.nvim_buf_create_user_command

    map("n", "K", function()
        return require("plugins.lsp.utils").fix_buf_hover()
    end, opts)
    map({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, opts)
    map("n", "gp", "<cmd>lua require'plugins.lsp.utils'.peek_definition()<CR>", opts)
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gt", vim.lsp.buf.type_definition, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "<leader>cdn", vim.diagnostic.goto_next, opts)
    map("n", "<leader>cdp", vim.diagnostic.goto_prev, opts)
    -- map("n", "<leader>cdl", "<cmd>Telescope diagnostics<CR>", opts)
    map("n", "<leader>cdl", "<cmd>lua require'plugins.telescope.utils'.diagnostics()<CR>", opts)
    map("n", "<leader>cr", vim.lsp.buf.rename, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map("x", "<leader>ca", vim.lsp.buf.range_code_action, opts)

    -- If formatting is available, create a binding and a command for it.
    -- The same config exists in the null-ls configuration.
    -- If the server does not support formatting, we can most
    -- likely do it through null-ls.
    if client.server_capabilities.documentFormattingProvider then
        map("n", "<leader>cf", vim.lsp.buf.format, opts)
    end

    -- Same, but for range formatting
    if client.server_capabilities.documentRangeFormattingProvider then
        map("x", "<leader>cf", vim.lsp.buf.range_formatting, opts)
    end

    -- utils.fmt_on_save(client, bufnr)
    utils.lsp_highlight_document(client, bufnr)
    utils.popup_diagnostics_on_hover(bufnr)
end

-- https://github.com/rebelot/dotfiles/blob/master/nvim/lua/lsp/lsp-config.lua
local function make_config(server_name)
    local ok, config = pcall(require, "plugins.lsp.servers." .. server_name)
    if not ok then
        config = {}
    end

    local client_on_attach = config.on_attach
    --
    -- wrap client-specific on_attach with default custom on_attach
    if client_on_attach then
        config.on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            client_on_attach(client, bufnr)
        end
    else
        config.on_attach = on_attach
    end

    config.capabilites = capabilities

    return config
end

for _, server in ipairs(servers) do
    -- call make_config() before trying to access lspconfig[server] to ensure
    -- registering custom servers
    local config = make_config(server)
    lspconfig[server].setup(config)
end

M = {}
M.on_attach = on_attach
M.capabilities = capabilities
-- M.handlers = handlers
return M
