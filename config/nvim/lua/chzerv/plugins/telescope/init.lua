local M = {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = { "<localleader>f", "<localleader>o" },
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "nvim-telescope/telescope-ui-select.nvim" },
    },
}

function M.config()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local actions_layout = require("telescope.actions.layout")

    local mappings = require("chzerv.plugins.telescope.mappings")

    telescope.setup({
        defaults = {
            prompt_prefix = "  ",
            selection_caret = "➜ ",
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
            file_ignore_patterns = {
                "node_modules",
                "pycache",
                ".venv/*",
                ".png$",
                ".jpg$",
                ".terraform",
            },
            path_display = { "truncate" },
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
                theme = "dropdown",
                previewer = false,
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
                theme = "dropdown",
                previewer = false,
                show_untracked = true,
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
                theme = "dropdown",
                previewer = false,
                mappings = {
                    i = {
                        ["<C-x>"] = require("telescope.actions").delete_buffer,
                    },
                },
            },
            current_buffer_fuzzy_find = {
                layout_config = {
                    horizontal = {
                        prompt_position = "bottom",
                        preview_width = 0.45,
                        results_width = 0.4,
                    },
                },
            },
            lsp_references = {
                path_display = { "shorten" },
                show_line = false,
            },
            oldfiles = {
                sort_lastused = true,
                -- cwd_only = true,
            },
        },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
end

return M