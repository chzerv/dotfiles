-- Keybindings to call specific telescope functions {{{
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

map("n", "<localleader>t", "<cmd>Telescope<CR>", opts)

map("n", "<localleader>f", "<cmd>lua require'chzerv.plugins.telescope.utils'.project_files()<CR>", opts)

map("n", "<localleader>F", "<cmd>lua require'chzerv.plugins.telescope.utils'.prompt_find_files()<CR>", opts)

map("n", "<localleader>o", "<cmd>Telescope oldfiles<CR>", opts)

map("n", "<localleader>b", "<cmd>Telescope buffers<CR>", opts)

map("n", "<localleader>:", "<cmd>Telescope commands<CR>", opts)

map("n", "<localleader>sw", "<cmd>Telescope live_grep<CR>", opts)

map("n", "<localleader>sb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", opts)

map("n", "<localleader>sp", "<cmd>lua require'chzerv.plugins.telescope.utils'.grep_prompt()<CR>", opts)

map("n", "<localleader>s/", "<cmd>lua require'chzerv.plugins.telescope.utils'.grep_last_search()<CR>", opts)

map("n", "<localleader>ed", "<cmd>lua require'chzerv.plugins.telescope.utils'.edit_dotfiles()<CR>", opts)

map("n", "<localleader>en", "<cmd>lua require'chzerv.plugins.telescope.utils'.edit_notes()<CR>", opts)

map("n", "<localleader>ep", "<cmd>lua require'chzerv.plugins.telescope.utils'.edit_projects()<CR>", opts)

map("n", "<localleader>gs", "<cmd>Telescope git_status<CR>", opts)

map("n", "<localleader>gc", "<cmd>Telescope git_commits<CR>", opts)

map("n", "<localleader>h", "<cmd>Telescope help_tags<CR>", opts)

map("n", "<localleader>/", "<cmd>Telescope search_history<CR>", opts)
