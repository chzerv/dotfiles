-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
-- https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
return {
    settings = {
        gopls = {
            experimentalPostfixCompletions = true,
            usePlaceholders = true,
            analyses = {
                unreachable = true,
                unusedparams = true,
                nilness = true,
                shadow = true,
            },
            staticcheck = true,
        },
    },
}
