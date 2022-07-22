vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us,el"
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2

local ok, surround = pcall(require, "nvim-surround")
if ok then

    -- Use via ySe or VSe
    surround.buffer_setup {
        delimiters = {
            pairs = {
                ["e"] = function()
                    local env = require("plugins.nvim-surround").get_input("Enter environment name: ")
                    if env then
                        return {
                            "\\begin{" .. env .. "}",
                            "\\end{" .. env .. "}"
                        }
                    end
                end
            },
        },
    }
end
