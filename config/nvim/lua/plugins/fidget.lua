local M = {
    "j-hui/fidget.nvim",
}

function M.setup()
    require("fidget").setup({
        text = {
            spinner = "dots_snake",
        },
        align = {
            bottom = true,
        },
        window = {
            relative = "editor",
            blend = 0,
        },
    })
end

return M
