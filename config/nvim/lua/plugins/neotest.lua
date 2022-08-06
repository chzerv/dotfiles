local M = {}

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local ok, neotest = pcall(require, "neotest")
if not ok then
    return
end

function M.setup()

    neotest.setup({
        discovery = { enabled = false },
        adapters = {
            require("neotest-rust")({}),
        },
    })

    -- Run the nearest test
    map("n", "<leader>nr", neotest.run.run, opts)

    -- Run all tests in the file
    map("n", "<leader>nR", function()
        neotest.run.run(vim.fn.expand("%"))
    end, opts)

    -- Open the test output and place the cursor inside the window
    map("n", "<leader>no", function()
        neotest.output.open({ enter = true })
        vim.cmd("stopinsert")
    end, opts)

    -- Toggle test summary
    map("n", "<leader>ns", neotest.summary.toggle, opts)

    -- Jump to the next/previous test
    map("n", "]n", neotest.jump.next, opts)
    map("n", "[n", neotest.jump.prev, opts)

end

return M
