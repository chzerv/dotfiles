local M = {}

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

M.setup = function()
    vim.diagnostic.config({
        -- Don't show diagnostics at the end of the line
        virtual_text = {
            severity = nil,
            source = "if_many",
            format = nil,
            prefix = "",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
            source = "always",
            border = "rounded",
            show_header = true,
            style = "minimal",
            format = function(diagnostic)
                if diagnostic.source == "" then
                    return diagnostic.message
                end

                if diagnostic.source == "ansible-lint" then
                    return string.format(
                        "%s [%s]\nMore info: %s\n",
                        diagnostic.message,
                        diagnostic.code,
                        diagnostic.user_data.lsp.codeDescription.href
                    )
                end
                return string.format("[%s] %s %s", diagnostic.source, diagnostic.code, diagnostic.message)
            end,
            suffix = function()
                return ""
            end,
        },
    })
end

return M
