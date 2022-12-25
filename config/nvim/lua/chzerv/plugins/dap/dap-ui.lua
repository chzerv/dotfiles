local M = {}

function M.setup()
    local dapui = require("dapui")

    local dap = require("dap")

    dapui.setup({
        layouts = {
            {
                elements = {
                    { id = "scopes", size = 0.25 },
                    "breakpoints",
                    -- "stacks",
                    -- "watches",
                },
                size = 80,
                position = "left",
            },
            {
                elements = {
                    "repl",
                    "console",
                },
                size = 10,
                position = "bottom",
            },
        },
    })

    -- Automatically open `dapui`
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open {}
    end
end

return M
