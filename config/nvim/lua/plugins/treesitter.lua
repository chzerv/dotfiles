----------------------------------------------
-- Configuration for treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
----------------------------------------------

local ok, ts = pcall(require, "nvim-treesitter.configs")
if not ok then
    return
end

ts.setup {
    ensure_installed = { "c", "lua", "rust", "bash", "dockerfile", "go", "javascript", "json", "latex", "python", "yaml" },

    sync_install = false,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { },

    highlight = {
        -- `false` will disable the whole extension
        enable = true,
        disable = { },
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = false,
    },
    -- nvim-treesitter/nvim-treesitter-textobjects
    textobjects = {
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
                ['al'] = '@loop.outer',
                ['il'] = '@loop.inner',
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['uc'] = '@comment.outer',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- Set jumps in the jumplist
            goto_next_start = {
                [']f'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']F'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[f'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[F'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<M-w>",
            node_incremental = "<M-w>",
            node_decremental = "<M-C-w.",
            scope_incremental = "<M-e>",
        }
    }
    --  JoosepAlviste/nvim-ts-context-commentstring
    -- context_commentstring = {
    --     enable = true,
    --     enable_autocmd = false, -- Not needed since we are using Comment.nvim
    -- },
}
