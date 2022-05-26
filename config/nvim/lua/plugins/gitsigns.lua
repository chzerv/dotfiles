------------------------------------------------
-- Configuration for the gitsigns plugin
-- https://github.com/lewis6991/gitsigns.nvim
------------------------------------------------

local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

gitsigns.setup {
    -- trouble = true,
    signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
}

-- Cycle through git hunks
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
map('n', ']g', [[<Cmd>Gitsigns next_hunk<CR>]], opts) -- Move to the next hunk
map('n', '[g', [[<Cmd>Gitsigns prev_hunk<CR>]], opts) -- Move to the previous hunk
map('n', '<Leader>gs', [[<Cmd>Gitsigns stage_hunk<CR>]], opts) -- Stage hunk under cursor
map('n', '<Leader>gb', [[<Cmd>Gitsigns stage_buffer<CR>]], opts) -- Stage whole buffer
map('n', '<Leader>gp', [[<Cmd>Gitsigns preview_hunk<CR>]], opts) -- Preview hunk
map('n', '<Leader>gd', [[<Cmd>Gitsigns reset_hunk<CR>]], opts) -- Undo hunk

