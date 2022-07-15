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

-- Open harpoon target in a vertical split.
-- All credits go to: https://www.reddit.com/r/neovim/comments/vweqbz/autocmd_to_open_harpoons_target_in_vsplit/
local group = vim.api.nvim_create_augroup("Harpoon Augroup", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "harpoon",
    group = group,
    callback = function()
        vim.keymap.set("n", "<C-V>", function()
            local curline = vim.api.nvim_get_current_line()
            local working_directory = vim.fn.getcwd() .. "/"
            vim.cmd("vs")
            vim.cmd("e " .. working_directory .. curline)
        end, { noremap = true, silent = true })
    end,
})
