--------------------------------------------------------
-- Configuration for telescope.nvim
-- https://github.com/nvim-telescope/telescope.nvim
--------------------------------------------------------

local ok, telescope = pcall(require, "telescope")
if not ok then
    return
end

local ok, mappings = pcall(require, "plugins.telescope.mappings")
if not ok then
    return
end

local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")

telescope.setup({
    defaults = {
        prompt_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending", -- ascending
        layout_strategy = "horizontal",
        winblend = 0,
        layout_config = {
            horizontal = {
                prompt_position = "bottom",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.8,
            height = 0.8,
            preview_cutoff = 100,
        },
        file_ignore_patterns = { "node_modules", ".git", "pycache" },
        path_display = {
            truncate = 1,
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--trim",
            "--glob=!.git/",
        },
        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-s>"] = actions.select_horizontal,
                ["<M-p>"] = actions_layout.toggle_preview,
                ["<C-e>"] = actions.results_scrolling_down,
                ["<C-y>"] = actions.results_scrolling_up,
            },
            n = {
                ["<C-e>"] = actions.results_scrolling_down,
                ["<C-y>"] = actions.results_scrolling_up,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
    pickers = {
        find_files = {
            mappings = {
                n = {
                    ["cd"] = function(prompt_bufnr)
                        local selection = require("telescope.actions.state").get_selected_entry()
                        local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                        require("telescope.actions").close(prompt_bufnr)
                        vim.cmd(string.format("silent lcd %s", dir))
                    end,
                },
            },
        },
        git_files = {
            mappings = {
                n = {
                    ["cd"] = function(prompt_bufnr)
                        local selection = require("telescope.actions.state").get_selected_entry()
                        local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                        require("telescope.actions").close(prompt_bufnr)
                        vim.cmd(string.format("silent lcd %s", dir))
                    end,
                    -- Switch to the "git status" view
                    ["gs"] = function()
                        local selection = require("telescope.actions.state").get_selected_entry()
                        require("telescope.builtin").git_status(selection)
                    end,
                },
            },
        },
        buffers = {
            sort_lastused = true,
            ignore_current_buffer = true,
        },
    },
})
