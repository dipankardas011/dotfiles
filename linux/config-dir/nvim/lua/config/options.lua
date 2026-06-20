-- Core editor options and globals.

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Disable netrw. Oil.nvim is used as the file explorer.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
vim.opt.hlsearch = true
vim.opt.winborder = 'single'
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

-- Tabs / indentation.
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.numberwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Use the system clipboard after startup so startup stays fast.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Transparent background.
vim.cmd([[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]])

vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#7fbbb3', bold = true })
