local map = vim.keymap.set
local builtin = require("telescope.builtin")

map("n", "<C-p>", "<cmd>lua require'plugins.telescope.utils'.project_files()<CR>", { desc = "Search git files" })
map("n", "<localleader>t", "<cmd>Telescope<cr>")
map("n", "<localleader>s", "<cmd>Telescope resume<cr>")
map("n", "<leader>,", builtin.buffers, { desc = "[b] Find open buffers" })

map("n", "<leader>so", builtin.oldfiles, { desc = "[S]earch [O]ld files" })
map("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Search the current buffer]" })

map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
map("n", "<leader>sF", "<cmd>lua require'plugins.telescope.utils'.prompt_find_files()<CR>",
    { desc = "Prompt for files to search for" }
)
map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
map({ "n", "x" }, "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord or selection" })
map("n", "<leader>sl", builtin.live_grep, { desc = "[S]earch using [L]ive grep" })
map("n", "<leader>sL", "<cmd>lua require'plugins.telescope.utils'.grep_prompt()<CR>",
    { desc = "Prompt for the word to grep for" }
)
map("n", "<leader>sn", "<cmd>lua require'plugins.telescope.utils'.edit_notes()<CR>", { desc = "[S]earch [N]otes" })
map("n", "<leader>sc", function() builtin.git_bcommits(require("telescope.themes").get_ivy()) end, {})
