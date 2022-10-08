local ok, dap = pcall(require, "dap")
if not ok then
    return
end

dap.defaults.fallback.external_terminal = {
    command = "/usr/bin/kitty",
    args = { "-e" },
}

dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode",
    name = "lldb",
}

dap.adapters.rust = dap.adapters.lldb

-- Credits to https://github.com/rcarriga/dotfiles/blob/master/.config/nvim/lua/config/dap.lua
-- for the `program` function
dap.configurations.rust = {
    {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
            local metadata_json = vim.fn.system("cargo metadata --format-version 1 --no-deps")
            local metadata = vim.fn.json_decode(metadata_json)
            local target_name = metadata.packages[1].targets[1].name
            local target_dir = metadata.target_directory
            return target_dir .. "/debug/" .. target_name
        end,
        -- cwd = "${workspaceFolder}",
        stopOnEntry = false,
        -- args = {},
        --runInTerminal = true,
    },
}

require("plugins.dap.mappings")
