-- Neovim 0.12+ configuration
-- Native package management via vim.pack. No lazy.nvim.

vim.loader.enable()

require('config.options')
require('packages')
require('plugins')
require('config.keymaps')
require('config.autocmds')
require('lsp')
require('autocomplete')
require('dap-config')

-- vim: ts=2 sts=2 sw=2 et
