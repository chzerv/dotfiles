local M = {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
}

function M.config()
    local gitsigns = require("gitsigns")

    local function on_attach(bufnr)

        local function map(mode, l, r, opts)
            opts = opts or {}
            if type(opts) == "string" then
                opts = { desc = opts }
            end
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        map("n", "]g", "<cmd>Gitsigns next_hunk<CR>")
        map("n", "[g", "<cmd>Gitsigns prev_hunk<CR>")

        map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>")
        map("n", "<leader>gB", "<cmd>Gitsigns blame_line<CR>")

        map("n", "<leader>gb", "<cmd>Gitsigns stage_buffer<CR>")
        map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>")
        map("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>")
        map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>")

        map("v", "<leader>gs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)

        map("v", "<leader>gr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    end

    gitsigns.setup({
        signs = {
            add = { hl = "GitSignsAdd", text = "+", linehl = "GitSignsAddLn" },
            change = { hl = "GitSignsChange", text = "~", linehl = "GitSignsChangeLn" },
            delete = { hl = "GitSignsDelete", text = "-", linehl = "GitSignsDeleteLn" },
            topdelete = { hl = "GitSignsDelete", text = "‾", linehl = "GitSignsDeleteLn" },
            changedelete = { hl = "GitSignsChange", text = "_", linehl = "GitSignsChangeLn" },
        },
        on_attach = on_attach,
        preview_config = {
            border = "rounded",
        },
    })
end

return M
