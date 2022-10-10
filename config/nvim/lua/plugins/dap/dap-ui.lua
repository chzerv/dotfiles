local dapui_ok, dapui = pcall(require, "dapui")
if not dapui_ok then
    return
end

local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
    return
end

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
