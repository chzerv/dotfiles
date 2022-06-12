-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
-- https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
return {
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                nilness = true,
                shadow = true,
            },
            usePlaceholders = true,
        },
    },
}
