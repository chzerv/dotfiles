-------------------------------------------------------------
-- Configuration for nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
-------------------------------------------------------------

local ok, ts = pcall(require, 'nvim-treesitter')
if not ok then
    return
end

require"nvim-treesitter.configs".setup({
    ensure_installed = {
        'bash', 'c', 'dockerfile', 'go', 'javascript', 'python', 'json', 'rust', 'yaml', 'vim', 'lua', 'html'
    },
    sync_install = false,
    highlight = {
        enable = true,
        disable = {
            "help",
        },
    },
    indent = {
        enable = true,
    },
    textobjects = {
        move = {
            enable = true,
            set_jumps = true, -- Set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer"
            },
        },
        select = {
            enable = true,
            lookahead = true,
        },
    },
})


