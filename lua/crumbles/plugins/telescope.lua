local ls = require "luasnip"

-- TODO: Think about `locally_jumpable`, etc.
-- Might be nice to send PR to luasnip to use filters instead for these functions ;)

vim.snippet.expand = ls.lsp_expand

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.active = function(filter)
  filter = filter or {}
  filter.direction = filter.direction or 1

  if filter.direction == 1 then
    return ls.expand_or_jumpable()
  else
    return ls.jumpable(filter.direction)
  end
end

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.jump = function(direction)
  if direction == 1 then
    if ls.expandable() then
      return ls.expand_or_jump()
    else
      return ls.jumpable(1) and ls.jump(1)
    end
  else
    return ls.jumpable(-1) and ls.jump(-1)
  end
end

vim.snippet.stop = ls.unlink_current





return {

    {
        'nvim-telescope/telescope.nvim', version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- optional but recommended
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        config = function()
            require("telescope").setup({})
        end,

        keys = {
            { '<leader>pf', "<cmd>Telescope find_files<cr>" },
            { '<C-p>', "<cmd>Telescope git_files<cr>" },
            { '<leader>ps', "<cmd>Telescope live_grep<cr>" },
            { '<leader>D', "<cmd>Telescope diagnostics<cr>" },
        }
    }

}
