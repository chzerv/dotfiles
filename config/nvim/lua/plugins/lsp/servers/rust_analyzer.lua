-- https://rust-analyzer.github.io/manual.html
return {
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "self",
            },
            cargo = {
                loadOutDirsFromCheck = true,
                autoreload = true,
            },
            procMacro = {
                enable = true,
            },
            inlayHints = {
                maxLength = 25,
                lifetimeElisionHints = {
                    enable = true,
                    useParameterNames = true
                },
            },
        },
    },
}
