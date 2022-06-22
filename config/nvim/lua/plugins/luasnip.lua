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
                virt_text = {{ " • ", "diffChanged"}}
            },
        },
    },
})

-- Key bindings {{{ 

-- Use <C-k> for expanding and jumping
vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- Use <C-j> for jumping backwards
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- Use <C-l> to select between choices
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)
-- }}}

-- for _, snip_file in ipairs(vim.api.nvim_get_runtime_file("lua/plugins/snippets/*.lua", true)) do
--     loadfile(snip_file)()
-- end

require("luasnip.loaders.from_lua").lazy_load({ paths = vim.api.nvim_get_runtime_file("lua/plugins/snippets", true)})
