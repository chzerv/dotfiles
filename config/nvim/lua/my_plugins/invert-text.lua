-- All credits go to: https://github.com/nguyenvukhang/nvim-toggler

local M = {}

local words = vim.tbl_add_reverse_lookup({
    ["true"] = "false",
    ["yes"] = "no",
    ["on"] = "off",
})

function M.invert()
    local cword = vim.tbl_get(words, vim.fn.expand("<cword>"))

    print(cword)

    pcall(function()
        vim.cmd("norm! ciw" .. cword)
    end)
end

return M
