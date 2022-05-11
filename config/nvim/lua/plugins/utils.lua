local M = {}

-- Fall back to 'Telescope find_files' instead of 'Telescope git_files' when not inside a git repository.
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory=
M.project_files = function()
    local opts = { noremap = true, silent = true }
    local ok = pcall(require"telescope.builtin".git_files, opts)
    if not ok then require"telescope.builtin".find_files(opts) end
end

M.find_notes = function()
    require('telescope.builtin').find_files(vim.tbl_deep_extend("force", { cwd = "~/Documents/Syncthing/Notes", prompt_title = "Search Notes.." }, opts or {}))
end

-- Stolen from LunarVim
-- https://github.com/LunarVim/LunarVim/blob/rolling/lua/lvim/core/telescope/custom-finders.lua
local _, finders = pcall(require, "telescope.finders")
local _, pickers = pcall(require, "telescope.pickers")
local _, sorters = pcall(require, "telescope.sorters")
local _, themes = pcall(require, "telescope.themes")
local _, actions = pcall(require, "telescope.actions")
local _, previewers = pcall(require, "telescope.previewers")
local _, make_entry = pcall(require, "telescope.make_entry")

local copy_to_clipboard_action = function(prompt_bufnr)
    local _, action_state = pcall(require, "telescope.actions.state")
    local entry = action_state.get_selected_entry()
    local version = entry.value
    vim.fn.setreg("+", version)
    vim.fn.setreg('"', version)
    vim.notify("Copied " .. version .. " to clipboard", vim.log.levels.INFO)
    actions.close(prompt_bufnr)
end

M.git_log = function()
    local opts = themes
    opts.entry_maker = make_entry.gen_from_git_commits(opts)

    pickers.new(opts, {
        prompt_title = "Git log",

        finder = finders.new_oneshot_job(
        vim.tbl_flatten {
            "git",
            "log",
            "--pretty=oneline",
            "--abbrev-commit",
        },
        opts
        ),
        previewer = {
            previewers.git_commit_diff_as_was.new(opts),
        },

        --TODO: consider opening a diff view when pressing enter
        attach_mappings = function(_, map)
            map("i", "<enter>", copy_to_clipboard_action)
            map("n", "q", actions._close)
            return true
        end,
        sorter = sorters.generic_sorter,
    }):find()
end

return M