local M = {
  "L3MON4D3/LuaSnip",
}

function M.config()
    local ls = require("luasnip")
    local types = require("luasnip.util.types")

    ls.config.set_config({
        -- Allows you to go back into a snippet if you accidentally exit out of it
        history = true,
        -- Update as you type
        update_events = "TextChanged,TextChangedI",
        ext_opts = {
            [types.choiceNode] = {
                active = {
                    -- virt_text = { { " <- Current Choice", "nonTest" } }
                    virt_text = { { " • ", "diffChanged" } }
                },
            },
        },
    })

    -- If we are inside a snippet, use <C-k> for expanding and jumping
    -- Otherwise, use <C-k> to go over a pair.
    -- All credits go to: https://github.com/Allaman/nvim/blob/main/lua/utils.lua#L66
    vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if ls.expand_or_jumpable() then
            ls.expand_or_jump()
        else
            local closers = { ")", "]", "}", ">", "'", '"', "`", "," }
            local line = vim.api.nvim_get_current_line()
            local row, col = unpack(vim.api.nvim_win_get_cursor(0))
            local after = line:sub(col + 1, -1)
            local closer_col = #after + 1
            local closer_i = nil
            for i, closer in ipairs(closers) do
                local cur_index, _ = after:find(closer)
                if cur_index and (cur_index < closer_col) then
                    closer_col = cur_index
                    closer_i = i
                end
            end
            if closer_i then
                vim.api.nvim_win_set_cursor(0, { row, col + closer_col })
            else
                vim.api.nvim_win_set_cursor(0, { row, col + 1 })
            end
        end
    end, { silent = true })

    -- Use <C-j> for jumping backwards
    vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if ls.jumpable(-1) then
            ls.jump(-1)
        end
    end, { silent = true })

    -- Use <C-l> to select between choices
    vim.keymap.set("i", "<c-l>", function()
        if ls.choice_active() then
            ls.change_choice(1)
        end
    end)

    require("luasnip.loaders.from_lua").lazy_load({ paths = vim.api.nvim_get_runtime_file("lua/plugins/snippets", true) })
end

return M
