--[[
Neovim configuration for Neovim 0.12+
Uses vim.pack (built-in plugin manager) instead of lazy.nvim.
]]--

-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

-- ============================================================
-- Core settings, keymaps, and autocommands
-- ============================================================
require('core')

-- ============================================================
-- Plugin management and configuration
-- ============================================================
require('plugins')

-- ============================================================
-- LSP configuration
-- ============================================================
require('lsp')

-- ============================================================
-- Completion configuration (nvim-cmp, LuaSnip)
-- ============================================================
require('autocomplete')

-- ============================================================
-- DAP configuration (debugger)
-- ============================================================
require('dap-config')

-- vim: ts=2 sts=2 sw=2 et
