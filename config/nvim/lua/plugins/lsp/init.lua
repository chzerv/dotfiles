-- Install servers
local servers = {
    "gopls",
    "rust_analyzer",
    "yamlls",
    "jsonls",
    "pyright",
    "sumneko_lua",
    "dockerls",
}

local installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if installer_ok then
    lsp_installer.setup({
        ensure_installed = servers,
    })
end

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
    return
end

local handlers_ok, handlers = pcall(require, "plugins.lsp.handlers")
if not handlers_ok then
    return
end

-- Override handlers
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = "rounded", silent = true, max_height = 10 }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = "rounded", silent = true, max_height = 10, relative = "cursor" }
)

for _, server in ipairs(servers) do

    -- Rust server initialization is handled by https://github.com/simrat39/rust-tools.nvim
    -- so there is no need to explicitly call `lspconfig.rust_analyzer.setup()`.
    if server ~= "rust_analyzer" then
        local opts = {
            capabilities = handlers.capabilities(),
            on_attach = function(client, bufnr)
                handlers.disable_formatting(client)
                handlers.lsp_mappings(bufnr)
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
end

-- FIXME: ansiblels is not working if installed via lsp-installer
lspconfig.ansiblels.setup({
    capabilities = handlers.capabilities(),
    on_attach = function(client, bufnr)
        handlers.disable_formatting(client)
        handlers.lsp_mappings(bufnr)
        -- handlers.popup_diagnostics_on_hover(bufnr)
        -- handlers.lsp_highlight_document(client, bufnr)
        -- handlers.fmt_on_save(client, bufnr)
    end,
    cmd = { "ansible-language-server", "--stdio" },
    settings = {
        ansible = {
            ansible = {
                useFullyQualifiedCollectionNames = true,
            },
            -- https://github.com/ansible/ansible-language-server/issues/391
            completion = {
                provideRedirectModules = false,
            },
        },
        ansibleLint = {
            enabled = false,
        },
    },
})

lspconfig.bashls.setup({
    capabilities = handlers.capabilities(),
    on_attach = function(client, bufnr)
        handlers.lsp_mappings(bufnr)
    end
})

lspconfig.hls.setup({
    capabilities = handlers.capabilities(),
    on_attach = function(client, bufnr)
        handlers.lsp_mappings(bufnr)
    end
})

local has_rust_tools, rust_tools = pcall(require, "rust-tools")
if has_rust_tools then
    rust_tools.setup({
        server = {
            on_attach = function(client, bufnr)
                handlers.lsp_mappings(bufnr)
            end,
            settings = {
                -- https://rust-analyzer.github.io/manual.html
                ["rust-analyzer"] = {
                    assist = {
                        importEnforceGranularity = true,
                        importPrefix = "crate",
                    },
                    cargo = {
                        allFeatures = true,
                    },
                    checkOnSave = {
                        command = "clippy",
                    },
                },
                inlayHints = {
                    lifetimeElisionHints = {
                        enable = true,
                        useParameterNames = true,
                    },
                },
            }
        }
    })
end

-- Setup diagnostics
require("plugins.lsp.diagnostics").setup()
