vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Oil.nvim replaces netrw.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
vim.opt.hlsearch = true
vim.opt.winborder = 'shadow'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.completeopt = 'menuone,noselect'
vim.opt.confirm = true
vim.opt.wrap = true
vim.opt.laststatus = 3
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.numberwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.cmd([[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]])
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#7fbbb3', bold = true })

local group = vim.api.nvim_create_augroup('user-general', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = group,
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  desc = 'Detect Helm templates',
  group = group,
  pattern = { '*/templates/*.yaml', '*/templates/*.tpl' },
  callback = function()
    vim.bo.filetype = 'helm'
  end,
})

require('plugins')
require('lsp')
require('keymaps')

-- vim: ts=2 sts=2 sw=2 et
