require("toggleterm").setup{
    -- size can be a number or function which is passed the current terminal
    size = function(term)
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
    open_mapping = [[<C-\>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = 'float',
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = 'curved',
        -- width = 20,
        -- height = 20,
        winblend = 0,
    },
}

local Terminal  = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
local ranger = Terminal:new({ cmd = "ranger", hidden = true })

function LAZYGIT_TOGGLE()
  lazygit:toggle()
end

function RANGER_TOGGLE()
  ranger:toggle()
end

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<A-g>", "<cmd>lua LAZYGIT_TOGGLE()<CR>", opts)
vim.keymap.set("n", "<A-r>", "<cmd>lua RANGER_TOGGLE()<CR>", opts)
