local ok, surround = pcall(require, "nvim-surround")
if not ok then
    return
end

surround.setup{}

-- https://github.com/kylechui/nvim-surround/issues/109#issuecomment-1194034971
require("nvim-surround.buffer").format_lines = function(_, _)
    -- Do nothing
end

local M = {}

M.get_input = function(prompt)
    local ok, input = pcall(vim.fn.input, { prompt = prompt })
    if not ok then
        return nil
    end
    return input
end

return M
