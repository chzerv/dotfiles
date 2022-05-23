return {
    settings = {
        Lua = {
            completion = {
                enable = true,
                showWord = 'Disable',
                -- keywordSnippet = 'Replace',
                -- callSnippet = 'Replace',
            },
            diagnostics = {
                global = { 'vim', 'dump' }
            },
            workspace = {
                -- Make the server aware of neovim runtime
                library = { os.getenv('VIMRUNTIME') }
            }
        },
    },
}
