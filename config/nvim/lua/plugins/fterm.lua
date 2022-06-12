local ok, fterm = pcall(require, "FTerm")
if not ok then
    return
end

fterm.setup({
    border = "double",
    dimensions = {
        height = 0.6,
        width = 0.7,
    },
})

-- Custom Terminals
local lazygit = fterm:new({
    ft = "fterm_lazygit",
    cmd = "lazygit",
    dimensions = {
        height = 0.9,
        width = 0.9,
    },
})

local python = fterm:new({
    ft = "fterm_python",
    cmd = "bpython",
    dimensions = {
        height = 0.8,
        width = 0.8,
    },
})

local ranger = fterm:new({
    ft = "fterm_ranger",
    cmd = "ranger",
    dimensions = {
        height = 0.9,
        width = 0.9,
    },
})

function _G.__fterm_lazygit()
    lazygit:toggle()
end

function _G.__fterm_python()
    python:toggle()
end

function _G.__fterm_ranger()
    ranger:toggle()
end

-- Example keybindings
local opts = { noremap = true }
vim.keymap.set("n", "<A-i>", '<CMD>lua require("FTerm").toggle()<CR>', opts)
vim.keymap.set("t", "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
vim.keymap.set("n", "<A-g>", "<CMD>lua __fterm_lazygit()<CR>", opts)
vim.keymap.set("n", "<A-r>", "<CMD>lua __fterm_ranger()<CR>", opts)

vim.api.nvim_create_user_command("CargoRun", function()
    require("FTerm").scratch({ cmd = { "cargo", "run" } })
end, { bang = true })

vim.api.nvim_create_user_command("AnsiblePlaybook", function()
    require("FTerm").run("ansible-playbook main.yml")
end, { bang = true })

vim.api.nvim_create_user_command("LAZYGIT", "lua __fterm_lazygit()", { bang = true })
vim.api.nvim_create_user_command("Ranger", "lua __fterm_ranger()", { bang = true })
vim.api.nvim_create_user_command("PYTHON", "lua __fterm_python()", { bang = true })
