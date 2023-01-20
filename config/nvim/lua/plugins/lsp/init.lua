return {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
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

        local lspconfig = require("lspconfig")
        local handlers = require("plugins.lsp.handlers")

        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")

        mason.setup()
        mason_lspconfig.setup({
            ensure_installed = servers,
        })

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
                    client.server_capabilities.semanticTokensProvider = nil
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
        require("plugins.null-ls").setup()
        require("plugins.fidget").setup()
        require("plugins.rust-tools").setup()
    end,
}
