--------------------------------------------------------
-- Configuration for telescope.nvim
-- https://github.com/nvim-telescope/telescope.nvim
--------------------------------------------------------

local ok, ts = pcall(require, "telescope")
if not ok then
    return
end

-- Don't preview binary files
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#dont-preview-binaries=

local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local new_maker = function(filepath, bufnr, opts)
    filepath = vim.fn.expand(filepath)
    Job:new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
            local mime_type = vim.split(j:result()[1], "/")[1]
            if mime_type == "text" then
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
            else
                -- maybe we want to write something to the buffer here
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
                end)
            end
        end
    }):sync()
end

ts.setup {
    defaults = {
        -- prompt_prefix = '▸ ',
        -- selection_caret = '▸ ',
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "bottom",
                preview_width = 0.60,
                results_width = 0.8,
            },
            width = 0.80,
            height = 0.80,
            preview_cutoff = 120,
        },
        buffer_previewer_maker = new_maker,
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
            '--trim',
            '--glob=!.git/'
        },
    },
    pickers = {
        find_files = {
            find_command = {
                'fd',
                '--type',
                'f',
                '--hidden',
                '--strip-cwd-prefix'
            }
        },
        git_files = {
            mappings = {
                n = {
                    -- Switch to the "git status" view
                    ["gs"] = function()
                        local selection = require('telescope.actions.state').get_selected_entry()
                        require("telescope.builtin").git_status(selection)
                    end
                }
            }
        }

    }
}

-- Keybindings to call specific telescope functions {{{
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

map('n', '<localleader>t', [[<Cmd>Telescope<CR>]], opts)
map('n', '<localleader>r', [[<Cmd>Telescope oldfiles<CR>]], opts) -- MRU (sort of)
map('n', '<localleader>b', [[<Cmd>Telescope buffers<CR>]], opts) -- Search open buffers
map('n', '<localleader>f', [[<Cmd>lua require'plugins.utils'.project_files()<CR>]], opts) -- Search for files
map('n', '<localleader>gs', [[<Cmd>Telescope git_status<CR>]], opts) -- Git status
map('n', '<localleader>gl', [[<Cmd>lua require'plugins.utils'.git_log()<CR>]], opts) -- Git log
map('n', '<localleader>s', [[<Cmd>Telescope live_grep<CR>]], opts) -- Live search in cwd
map('n', '<localleader>h', [[<Cmd>Telescope help_tags<CR>]], opts) -- :help
map('n', '<localleader>:', [[<Cmd>Telescope command_history<CR>]], opts) -- cmd history
map('n', '<localleader>/', [[<Cmd>Telescope search_history<CR>]], opts) -- Search history
map('n', '<localleader>k', [[<Cmd>Telescope keymaps<CR>]], opts) -- Show set keymaps
map('n', '<localleader>n', [[<Cmd>lua require'plugins.utils'.find_notes()<CR>]], opts) -- Search for files in my notes dir
-- }}}

