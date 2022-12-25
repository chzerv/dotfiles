return {
    settings = {
        ansible = {
            ansible = {
                useFullyQualifiedCollectionNames = true,
            },
            -- https://github.com/ansible/ansible-language-server/issues/391
            completion = {
                provideRedirectModules = false,
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
