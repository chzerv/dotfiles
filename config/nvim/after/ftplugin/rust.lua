local opts = { noremap = true, silent = true }
local map = vim.keymap.set

map("n", "<leader>rd", "<cmd>RustOpenExternalDocs<cr>", opts)

map("n", "<leader>rr", "<cmd>RustRunnables<cr>", opts)

map("n", "<leader>rc", "<cmd>RustOpenCargo<cr>", opts)

map("n", "<leader>rR", "<cmd>RustOpenCargo<cr>", opts)

map("n", "<leader>rR", "<cmd>CargoReload<cr>", opts)
