-- Global autocommands.

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local general = augroup('user-general', { clear = true })

-- Highlight yanked text.
autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = general,
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Helm filetype detection.
autocmd({ 'BufRead', 'BufNewFile' }, {
  desc = 'Detect Helm templates',
  group = general,
  pattern = { '*/templates/*.yaml', '*/templates/*.tpl' },
  callback = function()
    vim.bo.filetype = 'helm'
  end,
})
