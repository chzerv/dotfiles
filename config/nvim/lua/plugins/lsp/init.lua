---------------------------------------------------------
-- LSP Configuration using lspconfig.
-- Server installation is handled by nvim-lsp-installer
---------------------------------------------------------

require("plugins.lsp.diagnostics").setup()

-- Install LSP servers

local servers = {
    "pyright",
    "ansiblels",
    "yamlls",
    "bashls",
    "dockerls",
    "jsonls",
    "sumneko_lua",
}

local ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if ok then
    lsp_installer.setup {
        ensure_installed = servers,
        automatic_installation = true,
        ui = {
            icons = {
                server_installed = "✓",
                server_pending = "➜",
                server_uninstalled = "✗"
            }
        }
    }
end

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
    return
end

local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_ok then
    return
end

-- Override handlers
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded', silent = true, max_height = 10 })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded', silent = true, max_height = 10 })

-- Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local map = vim.keymap.set
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gD", vim.lsp.buf.declaration, opts)
    map("n", "gt", vim.lsp.buf.type_definition, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "<leader>cdn", vim.diagnostic.goto_next, opts)
    map("n", "<leader>cdp", vim.diagnostic.goto_prev, opts)
    map("n", "<leader>cdl", "<cmd>Telescope diagnostics<CR>", opts)
    map("n", "<leader>cr", vim.lsp.buf.rename, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map({"n", "i"}, "<C-s>", vim.lsp.buf.signature_help, opts)

    -- Highlight symbol under cursor, if supported by the server
    -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#highlight-symbol-under-cursor=
    if client.server_capabilities.documentHighlightProvider then
        local lsp_references_au_id = vim.api.nvim_create_augroup("LSP_references", { clear = true })
        vim.api.nvim_create_autocmd("CursorHold", {
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
            group = lsp_references_au_id,
            desc = "LSP document highlight",
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
            group = lsp_references_au_id,
            desc = "Clear LSP document highlight",
        })
    end

    -- Show diagnostics on a float window when you hover over a symbol
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = 'rounded',
                source = 'always',
                prefix = ' ',
                scope = 'cursor',
            }
            vim.diagnostic.open_float(nil, opts)
        end
    })

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
