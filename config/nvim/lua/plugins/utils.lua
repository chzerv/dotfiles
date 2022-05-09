-- Fall back to 'Telescope find_files' instead of 'Telescope git_files'
-- when not inside a git repository.
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory=

local M = {}

M.project_files = function()
    local opts = { noremap = true, silent = true }
    local ok = pcall(require"telescope.builtin".git_files, opts)
    if not ok then require"telescope.builtin".find_files(opts) end
end

M.find_notes = function()
    require('telescope.builtin').find_files(vim.tbl_deep_extend("force", { cwd = "~/Documents/Syncthing/Notes", prompt_title = "Search Notes.." }, opts or {}))
end

return M
