vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.opt_local.foldmethod = "manual"
vim.opt_local.conceallevel = 2
vim.opt_local.formatoptions:append("t")

-- https://github.com/kylechui/nvim-surround/discussions/53
local ok, surround = pcall(require, "nvim-surround")
if ok then
    surround.buffer_setup({
        delimiters = {
            pairs = {
                ["l"] = function()
                    return {
                        "[",
                        "](" .. vim.fn.getreg("*") .. ")",
                    }
                end,
            },
        },
    })
end

vim.g.vim_markdown_folding_disabled = true
vim.g.vim_markdown_conceal = true
vim.g.vim_markdown_conceal_code_blocks = false
vim.g.vim_markdown_frontmatter = true
vim.g.vim_markdown_toml_frontmatter = false
vim.g.vim_markdown_json_frontmatter = false
vim.g.vim_markdown_no_extensions_in_markdown = false
vim.g.vim_markdown_follow_anchor = true
