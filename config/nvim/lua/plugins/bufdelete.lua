local ok, bufdelete = pcall(require, "bufdelete")
if not ok then
    return
end


vim.keymap.set("n", "<leader>bd", "<cmd> Bdelete<CR>", { noremap = true, silent = true })
