local map = vim.keymap.set
local opts = { silent = true, noremap = true }

map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
map("n", "<Leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
map("n", "<Leader>dl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)

map("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", opts)
map("n", "<F10>", "<Cmd>lua require'dap'.step_over()<CR>", opts)
map("n", "<F11>", "<Cmd>lua require'dap'.step_into()<CR>", opts)
map("n", "<F12>", "<Cmd>lua require'dap'.step_out()<CR>", opts)

map("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<CR>", opts)
