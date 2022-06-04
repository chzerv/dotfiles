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
        },
    },
}
