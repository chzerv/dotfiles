local M = {
    "numToStr/Comment.nvim",
    keys = { "gc", "gcc", "gbc", { "gc", mode = "v" } },
}

function M.config()
    require("Comment").setup()
end

return M
