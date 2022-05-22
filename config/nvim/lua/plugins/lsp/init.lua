---------------------------------------------------------
-- LSP Configuration using lspconfig.
-- Server installation is handled by lsp-installer.
---------------------------------------------------------

-- Install LSP servers

local servers = {
    "pyright",
    "ansiblels",
    "yamlls",
    "bashls",
    "dockerls",
    "jsonls",
    "sumneko_lua"
}

local ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if ok then
    lsp_installer.setup {
        ensure_installed = servers,
        automatic_installation = true,
    }
end

-- Configure LSP
local lsp_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_ok then
    return
end

local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_ok then
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
        vim.keymap.set({"n", "i"}, "<C-s>", vim.lsp.buf.signature_help, opts)
    end

-- https://stackoverflow.com/questions/9145432/load-lua-files-by-relative-path
local folderOfThisFile = (...):match("(.-)[^%.]+$")

for _, server in ipairs(servers) do
    -- Standard opts
    local opts = {
        on_attach = on_attach,
        capabilities =capabilities
    }
    -- Look for server specific opts in ./options/<server name>
    local has_custom_opts, server_custom_opts = pcall(require, folderOfThisFile .. "options." .. server)
    if has_custom_opts then
        opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
    end
    lspconfig[server].setup(opts)
end
