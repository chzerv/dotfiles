return {
    settings = {
        ansible = {
            ansible = {
                useFullyQualifiedCollectionNames = true,
            },
            completion = {
                provideRedirectModules = true,
                provideModuleOptionAliases = true,
            },
        },
        -- Let null-ls handle linting
        validation = {
            lint = {
                enabled = false
            }
        }
    },
}
