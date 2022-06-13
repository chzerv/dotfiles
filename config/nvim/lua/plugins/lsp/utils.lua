local U = {}

local augroup = vim.api.nvim_create_augroup("Formatting", { clear = true })

function U.fmt_on_save(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    bufnr = bufnr,
                    timeout_ms = 3000,
                })
            end,
        })
    end
end

-- https://www.reddit.com/r/neovim/comments/pg1o6k/neovim_lsp_hover_window_is_hidden_behind_line/
function U.fix_buf_hover()
    vim.o.eventignore = "CursorHold"
    vim.lsp.buf.hover()
    vim.cmd([[autocmd CursorMoved <buffer> ++once set eventignore=""]])
end

return U
