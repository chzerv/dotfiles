local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>ha", function()
    require("harpoon.mark").add_file()
end, opts)

map("n", "<leader>hh", function()
    require("harpoon.ui").toggle_quick_menu()
end, opts)

for i = 1, 5 do
    map("n", string.format("<leader>%s", i), function()
        require("harpoon.ui").nav_file(i)
    end, opts)
end
