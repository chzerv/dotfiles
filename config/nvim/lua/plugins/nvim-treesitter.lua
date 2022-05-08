-------------------------------------------------------------
-- Configuration for nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
-------------------------------------------------------------

local ok, ts = pcall(require, 'nvim-treesitter')
if not ok then
    return
end

ts.setup({
    matchup = {
        enable = true,
    },
    ensure_installed = {
        'bash', 'c', 'dockerfile', 'go', 'javascript', 'python', 'json', 'rust', 'yaml', 'vim', 'lua', 'html'
    },
    sync_install = false,
    highlight = {
        enable = true
    }
})
