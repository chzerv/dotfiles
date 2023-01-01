-- local opts = { noremap = true, silent = true }
local map = vim.keymap.set
local builtin = require('telescope.builtin')

map('n', '<leader>so', builtin.oldfiles, { desc = '[S]earch [O]ld files' })
map('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer]' })

map("n", "<localleader>t", "<cmd>Telescope<cr>")
map('n', '<C-p>', builtin.git_files, { desc = 'Search git files' })
map('n', '<leader><space>', builtin.buffers, { desc = '[b] Find open buffers' })
map('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })

-- map("n", "<localleader>t", "<cmd>Telescope<CR>", opts)
--
-- map("n", "<localleader>f", "<cmd>lua require'plugins.telescope.utils'.project_files()<CR>", opts)
--
-- map("n", "<localleader>F", "<cmd>lua require'plugins.telescope.utils'.prompt_find_files()<CR>", opts)
--
-- map("n", "<localleader>o", "<cmd>Telescope oldfiles<CR>", opts)
--
-- map("n", "<localleader>b", "<cmd>Telescope buffers<CR>", opts)
--
-- map("n", "<localleader>:", "<cmd>Telescope commands<CR>", opts)
--
-- map("n", "<localleader>sw", "<cmd>Telescope live_grep<CR>", opts)
--
-- map("n", "<localleader>sb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", opts)
--
-- map("n", "<localleader>sp", "<cmd>lua require'plugins.telescope.utils'.grep_prompt()<CR>", opts)
--
-- map("n", "<localleader>s/", "<cmd>lua require'plugins.telescope.utils'.grep_last_search()<CR>", opts)
--
-- map("n", "<localleader>ed", "<cmd>lua require'plugins.telescope.utils'.edit_dotfiles()<CR>", opts)
--
-- map("n", "<localleader>en", "<cmd>lua require'plugins.telescope.utils'.edit_notes()<CR>", opts)
--
-- map("n", "<localleader>ep", "<cmd>lua require'plugins.telescope.utils'.edit_projects()<CR>", opts)
--
-- map("n", "<localleader>gs", "<cmd>Telescope git_status<CR>", opts)
--
-- map("n", "<localleader>gc", "<cmd>Telescope git_commits<CR>", opts)
--
-- map("n", "<localleader>h", "<cmd>Telescope help_tags<CR>", opts)
--
-- map("n", "<localleader>/", "<cmd>Telescope search_history<CR>", opts)