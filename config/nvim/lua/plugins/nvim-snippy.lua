--------------------------------------------
-- Configuration for vim-snippy
-- https://github.com/dcampos/nvim-snippy
--------------------------------------------

local snippy = require('snippy')
local snippets_dir = vim.fn.stdpath('config') .. '/snippets'

snippy.setup({
    snippet_dirs = snippets_dir,
    -- hl_group = 'Search',
    enable_auto = false,
})

local function jump_next()
    return snippy.can_jump(1) and '<Plug>(snippy-next)' or '<Tab>'
end

local function jump_prev()
    return snippy.can_jump(-1) and '<Plug>(snippy-previous)' or '<S-Tab>'
end

local function expand_or_advance()
    return snippy.can_expand() and '<Plug>(snippy-expand)' or jump_next()
end

vim.keymap.set('i', '<Tab>', expand_or_advance, { expr = true, remap = true })
vim.keymap.set('s', '<Tab>', jump_next, { expr = true, remap = true })
vim.keymap.set({ 'i', 's' }, '<S-Tab>', jump_prev, { expr = true, remap = true })
vim.keymap.set('x', '<Tab>', '<Plug>(snippy-cut-text)', { remap = true })
vim.keymap.set('n', 'g<Tab>', '<Plug>(snippy-cut-text)', { remap = true })
