if vim.fn.executable("ansible-doc") then
    vim.bo.keywordprg = ":sp term://ansible-doc"
end

-- Search in the 'templates' and 'files' directories when using 'gf'
vim.bo.path = vim.bo.path .. ",templates/,files/"
