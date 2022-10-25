local has_rust_tools, _ = pcall(require, "rust-tools")
if has_rust_tools then

    local opts = { noremap = true, silent = true, buffer = true }
    local map = vim.keymap.set

    map("n", "<leader>rd", "<cmd>RustOpenExternalDocs<cr>", opts)
    map("n", "<leader>rr", "<cmd>RustRunnables<cr>", opts)
    map("n", "<leader>rd", "<cmd>RustDebuggables<cr>", opts)
    map("n", "<leader>rc", "<cmd>RustOpenCargo<cr>", opts)
    map("n", "<leader>rR", "<cmd>CargoReload<cr>", opts)
end
