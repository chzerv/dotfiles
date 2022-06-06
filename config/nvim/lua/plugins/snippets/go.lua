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
        "imp",
        fmt(
            [[
        import (
            "{}"
        )
        {}
        ]],
            { i(1, "fmt"), i(2) }
        )
    ),
    s("prln", { t("fmt.Println("), i(1), t(")") }),
    s("prf", { t("fmt.Printf("), i(1), t(")") }),
})