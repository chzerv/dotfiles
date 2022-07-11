local nmap = require("core.utils").nmap
local opts = { noremap = true, silent = true }

nmap({
    "<leader>ha",
    function()
        require("harpoon.mark").add_file()
    end,
   opts,
})

nmap({
    "<leader>hh",
    function()
        require("harpoon.ui").toggle_quick_menu()
    end,
    opts,
})

for i = 1, 5 do
    nmap({
        string.format("<leader>%s", i),
        function()
            require("harpoon.ui").nav_file(i)
        end,
        opts,
    })
end
