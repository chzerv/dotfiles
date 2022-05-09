--------------------------------------------------------
-- Configuration for telescope.nvim
-- https://github.com/nvim-telescope/telescope.nvim
--------------------------------------------------------

local ok, ts = pcall(require, "telescope")
if not ok then
    return
end

local actions = require("telescope.actions")

ts.setup {
    defaults = {
        mappings = {
            i = {
                ["<C-u>"] = false
            },
        },
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
        }
    }
}

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
    buffer_previewer_maker = new_maker,
  }
}

-- Keybindings to call specific telescope functions {{{
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

map('n', '<localleader>t', [[<Cmd>Telescope<CR>]], opts) -- Show set keymaps
map('n', '<localleader>r', [[<Cmd>Telescope oldfiles<CR>]], opts) -- Show set keymaps
map('n', '<localleader>b', [[<Cmd>Telescope buffers<CR>]], opts) -- Search open buffers
map('n', '<localleader>f', [[<Cmd>lua require'plugins.utils'.project_files()<CR>]], opts) -- Search for files
map('n', '<localleader>g', [[<Cmd>Telescope live_grep<CR>]], opts) -- Live search in cwd
map('n', '<localleader>h', [[<Cmd>Telescope help_tags<CR>]], opts) -- :help
map('n', '<localleader>:', [[<Cmd>Telescope command_history<CR>]], opts) -- Cmdline history
map('n', '<localleader>/', [[<Cmd>Telescope search_history<CR>]], opts) -- Search history
map('n', '<localleader>k', [[<Cmd>Telescope keymaps<CR>]], opts) -- Show set keymaps
map('n', '<localleader>n', [[<Cmd>lua require'plugins.utils'.find_notes()<CR>]], opts) -- Search for files
-- }}}
