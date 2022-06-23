return {
    cmd = {
        "ansible-language-server", "--stdio"
    },
    settings = {
        ansible = {
            ansible = {
                useFullyQualifiedCollectionNames = true,
            },
            ansibleLint = {
                enabled = false,
            },
        },
    },
}
