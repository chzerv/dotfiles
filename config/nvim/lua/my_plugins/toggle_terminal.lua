local M = {}

local term_buf = nil
local term_win = nil

function M.toggle_term(direction, size)
    if vim.fn.win_gotoid(term_win) == 1 then
        vim.cmd("hide")
    else
        if vim.fn.bufexists(term_buf) ~= 1 then
            if direction == "split" then
                vim.cmd("botright new | res " .. size .. " | terminal")
            elseif direction == "vsplit" then
                vim.cmd("vertical new | vert res " .. size .. " | terminal")
            end
            term_buf = vim.fn.bufnr("%")
            term_win = vim.fn.win_getid()
        else
            if direction == "split" then
                vim.cmd("sb " .. term_buf .. " | res " .. size)
            elseif direction == "vsplit" then
                vim.cmd("vert sb " .. term_buf .. " | vert res " .. size)
            end
            term_win = vim.fn.win_getid()
        end
        vim.cmd("startinsert")
    end
end

return M
