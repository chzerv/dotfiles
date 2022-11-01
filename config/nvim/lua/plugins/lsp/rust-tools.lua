local handlers_ok, handlers = pcall(require, "plugins.lsp.handlers")
if not handlers_ok then
    return
end

local rust_tools_ok, rust_tools = pcall(require, "rust-tools")
if not rust_tools_ok then
    return
end

local extension_path = vim.env.HOME .. '/.local/share/nvim/mason/packages/codelldb/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

rust_tools.setup({
    tools = {
        hover_actions = {
            max_height = 20,
            max_width = 100,
        },
        inlay_hints = {
            auto = true,
            only_current_line = true,
            show_parameter_hints = false,
        }
    },
    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb_path, liblldb_path
        )
    },
    server = {
        on_attach = function(client, bufnr)
            handlers.lsp_mappings(client, bufnr)
            handlers.codelens(client, bufnr)
        end,
        cmd = { "rust-analyzer" },
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
