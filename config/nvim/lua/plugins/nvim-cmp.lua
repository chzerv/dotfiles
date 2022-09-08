-----------------------------------------
--
-- Configuration for nvim-cmp
-- https://github.com/hrsh7th/nvim-cmp
-----------------------------------------

local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
    return
end

local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then
    return
end

local icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },

    experimental = {
        ghost_text = false,
    },

    mapping = {
        -- If pummenu is visible, select next item. If not, trigger completion
        ["<C-n>"] = function()
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            else
                cmp.complete()
            end
        end,
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping(
            cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            }),
            { "i", "c" }
        ),
    },

    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    },

    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, item)
            -- Kind icons
            item.kind = string.format("%s %s", icons[item.kind], item.kind)

            -- Source
            item.menu = ({
                path = "[path]",
                nvim_lsp = "[LSP]",
                buffer = "[buf]",
                luasnip = "[snip]",
            })[entry.source.name]

            -- Partly show matches longer than 45 characters
            if #item.abbr > 45 then
                item.abbr = item.abbr:sub(1, 45) .. "..."
            end

            return item
        end,
    },
    sorting = {
        comparators = {
            cmp.config.compare.sort_text,
            cmp.config.compare.offset,
            -- cmp.config.compare.exact,
            cmp.config.compare.score,
            -- cmp.config.compare.kind,
            -- cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
})
