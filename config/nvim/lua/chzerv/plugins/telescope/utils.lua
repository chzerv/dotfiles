-- Lot of ideas taken from tjdevries:
-- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/telescope/init.lua

local M = {}

local themes = require("telescope.themes")

-- Fall back to find_files if git_files can't find a .git directory
function M.project_files()
    local opts = {}
    local ok = pcall(require("telescope.builtin").git_files, opts)
    if not ok then
        require("telescope.builtin").find_files(opts)
    end
end

-- Search my dotfiles
function M.edit_dotfiles()
    local opts = {
        prompt_title = "~ dotfiles ~",
        shorten_path = false,
        cwd = "~/Projects/dotfiles",
    }

    require("telescope.builtin").find_files(opts)
end

-- Search my notes
function M.edit_notes()
    local opts = {
        prompt_title = "~  notes  ~",
        cwd = "~/Documents/Syncthing/Notes",
    }

    require("telescope.builtin").find_files(opts)
end

function M.edit_projects()
    local opts = {
        prompt_title = "~  Projects  ~",
        cwd = "~/Projects",
    }

    require("telescope.builtin").find_files(opts)
end

-- Prompt user for a string, and run 'Telescope grep_string search=<string>'
function M.grep_prompt()
    local opts = {
        path_display = { "shorten" },
        search = vim.fn.input("Grep For > "),
    }

    require("telescope.builtin").grep_string(opts)
end

function M.grep_last_search(opts)
    opts = opts or {}

    local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")

    opts.path_display = { "shorten" }
    opts.word_match = "-w"
    opts.search = register
    opts.prompt_title = "Grep last search"

    require("telescope.builtin").grep_string(opts)
end

function M.prompt_find_files()
    require("telescope.builtin").find_files({
        path_display = { "truncate" },
        cwd = vim.fn.input("Search in > "),
    })
end

-- Give more space to the diagnostics, the preview is not so important
function M.diagnostics()
    local opts = themes.get_dropdown({
        winblend = 5,
        -- previewer = false,
    })

    require("telescope.builtin").diagnostics(opts)
end

return M
