return {
    settings = {
        yaml = {
            schemaStore = {
                url = "https://www.schemastore.org/api/json/catalog.json",
                enable = true,
            },
            schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
            }
        },
    },
}
