------------------------------------------------
-- Configuration for nvim-autopairs
-- https://github.com/windwp/nvim-autopairs
------------------------------------------------

local ok, autopairs = pcall(require, 'nvim-autopairs')
if not ok then
    return
end

local Rule = require'nvim-autopairs.rule'
local cond = require'nvim-autopairs.conds'

autopairs.setup({
    enable_check_bracket_line = true,
    disable_filetype = { 'TelescopePrompt' },
})

-- Add space between (), {}, and []
-- https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#add-spaces-between-parentheses=
autopairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    end),
  Rule('( ', ' )')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%)') ~= nil
      end)
      :use_key(')'),
  Rule('{ ', ' }')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%}') ~= nil
      end)
      :use_key('}'),
  Rule('[ ', ' ]')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%]') ~= nil
      end)
      :use_key(']')
}
