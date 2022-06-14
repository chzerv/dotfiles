local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

-- Simple placeholders
ls.add_snippets("go", {
    s(
        "main",
        fmt(
            [[
        func main() {{
            {}
        }}
        {}
        ]],
            { i(1), i(2) }
        )
    ),
    s(
        "forn",
        fmt(
            [[
        for i := 0; i {} {}; i++ {{
            {}
        }}
        {}
        ]],
            {
                c(1, { t("<"), t("<="), t(">"), t(">=") }),
                i(2, "n"),
                i(3, "body"),
                i(4),
            }
        )
    ),
    s(
        "fn",
        fmt(
            [[
        func {}({}) {{
            {}
        }}
        {}
        ]],
            { i(1, "name"), i(2, "args"), i(3, "body"), i(0) }
        )
    ),
    s(
        "meth",
        fmt(
            [[
        func ({} {}) {}({}) {} {{
            {}
        }}
        {}
        ]],
            { i(1, "receiver"), i(2, "type"), i(3, "name"), i(4), i(5), i(6, "body"), i(0) }
        )
    ),
})
