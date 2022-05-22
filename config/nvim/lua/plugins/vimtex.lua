-----------------------------------------
-- Configuration for vimtex
-- https://github.com/lervag/vimtex
-----------------------------------------

local g = vim.g

if vim.fn.executable("evince") then
    g.vimtex_view_general_viewer = "evince"
elseif vim.fn.executable("okular") then
    g.vimtex_view_general_viewer = "okular"
end


g.vimtex_quickfix_ignore_filters = {
    "Command terminated with space",
    "LaTeX Font Warning: Font shape",
    "Package caption Warning: The option",
    [[Underfull \\hbox (badness [0-9]*) in]],
    "Package enumitem Warning: Negative labelwidth",
    [[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in]],
    [[Package caption Warning: Unused \\captionsetup]],
    "Package typearea Warning: Bad type area settings!",
    [[Package fancyhdr Warning: \\headheight is too small]],
    [[Underfull \\hbox (badness [0-9]*) in paragraph at lines]],
    "Package hyperref Warning: Token not allowed in a PDF string",
    [[Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in paragraph at lines]],
}
