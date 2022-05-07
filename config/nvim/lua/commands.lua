-----------------
-- Autocommands
-----------------

local cmd = vim.cmd

-- Highlight yanked text.
-- Replacement for https://github.com/machakann/vim-highlightedyank
cmd("au TextYankPost * silent! lua vim.highlight.on_yank({ higroup='WarningMsg', timeout='200' })")
