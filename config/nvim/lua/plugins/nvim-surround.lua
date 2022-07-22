local ok, surround = pcall(require, "nvim-surround")
if not ok then
    return
end

surround.setup{}

local M = {}

M.get_input = function(prompt)
    local ok, input = pcall(vim.fn.input, { prompt = prompt })
    if not ok then
        return nil
    end
    return input
end

return M
