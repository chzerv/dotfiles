return {
    "echasnovski/mini.nvim",
    event = "InsertCharPre",
    config = function()
        require("mini.pairs").setup()
        require("mini.align").setup()
        require("mini.move").setup({
            mappings = {
                left = "<C-h>",
                right = "<C-l>",
                down = "<C-j>",
                up = "<C-k>",

                line_left = "<C-h>",
                line_right = "<C-l>",
                line_down = "<C-j>",
                line_up = "<C-k>",
                -- Move current line in Normal mode
            },
        })
    end,
}
