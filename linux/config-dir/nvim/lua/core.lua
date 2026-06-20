-- [[ Core settings, keymaps, and autocommands ]]

-- Disable netrw (we use oil.nvim)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

-- Transparent background
vim.cmd([[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]])

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- [[ General options ]]
vim.o.hlsearch = true
vim.o.winborder = "single"
vim.o.number = true
vim.o.mouse = "a"
vim.o.showmode = false
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.completeopt = "menuone,noselect"
vim.o.confirm = true

-- Tabs
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.numberwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

vim.wo.relativenumber = true
vim.wo.wrap = true

vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#7fbbb3", bold = true })

-- [[ Statusline helpers ]]
local function get_git_branch()
  local branch = vim.b.gitsigns_head or ""
  if branch == "" then
    return ""
  end

  local status = vim.b.gitsigns_status_dict
  local added, changed, removed = 0, 0, 0
  if status then
    added = status.added or 0
    changed = status.changed or 0
    removed = status.removed or 0
  end

  local diff_str = ""
  diff_str = diff_str .. " +" .. added
  diff_str = diff_str .. " ✕" .. removed
  diff_str = diff_str .. " ±" .. changed

  return string.format("[%s%s] ", branch, diff_str)
end

local function mode_alias()
  local m = vim.api.nvim_get_mode().mode
  local alias = {
    n = "NOR", no = "N-PENDING", v = "VIS", V = "VLI",
    [""] = "VBL", i = "INS", ic = "INS", R = "REP",
    c = "COM", cv = "VIM EX", ce = "EX", s = "SEL",
    S = "S-LINE", [""] = "S-BLOCK", t = "TER",
  }
  return alias[m] or m
end

_G.mode_alias = mode_alias
_G.get_git_branch = get_git_branch

vim.opt.statusline = [[%#StatusLine# %{v:lua.mode_alias()} %=%{v:lua.get_git_branch()}%<%f %m%r%h%w %=%y  %l:%-2v]]
vim.o.laststatus = 3 -- global statusline

-- [[ Keymaps ]]
local map = vim.keymap.set

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Tab navigation with Alt+number
for i = 1, 9 do
  map("n", "<A-" .. i .. ">", i .. "gt", { noremap = true, silent = true })
end

-- Word wrap navigation
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

map("n", "<leader>b", ":Oil --float<CR>", { desc = "Open Oil file explorer" })

-- Terminal toggles (nvterm)
map({ "n", "t" }, "<A-h>", function()
  require("nvterm.terminal").toggle("horizontal")
end, { desc = "[A]ctivate terminal [H]orizontal" })
map({ "n", "t" }, "<A-v>", function()
  require("nvterm.terminal").toggle("vertical")
end, { desc = "[A]ctivate terminal [V]ertical" })
map({ "n", "t" }, "<A-i>", function()
  require("nvterm.terminal").toggle("float")
end, { desc = "[A]ctivate terminal Float" })

map("n", "<C-Tab>", ":bdelete<CR>", { desc = "close buffer" })
map("n", "<Tab>", ":bnext<CR>", { desc = "next buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "prev buffer" })
map("n", "<Leader>t", ":tabnew<CR>", { desc = "new tab" })

-- DAP keymaps
map("n", "<F5>", function()
  require("dap").continue()
end, { desc = "Go debug CONTINUE" })
map("n", "<Leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "[D]ebug [b]reakpoint" })
map("n", "<Leader>dU", function()
  require("dapui").toggle()
end, { desc = "[D]ebug UI toggle" })
map("n", "<Leader>lp", function()
  require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "[l]og pointer for debug" })

-- Git keymaps
map("n", "<leader>gsp", ":Git add -p .<CR>", { desc = "Git add with prompt" })
map("n", "<leader>gsa", ":Git add .<CR>", { desc = "Git add all" })
map("n", "<leader>gcs", ":Git commit -sv<CR>", { desc = "git commit with sign" })
map("n", "<leader>aigc", ":CodeCompanion /commit<CR>", { desc = "generate commit message" })
map("n", "<leader>ai", ":CodeCompanionChat<CR>", { desc = "Get AI Chat" })

-- Move selected lines
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Keep search terms centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Preserve clipboard on paste
map("x", "<leader>p", '"_dP')

-- Save / quit
map("n", "<C-s>", ":w<CR>", { desc = "Save the file" })
map("n", "<C-q>", ":bdelete<CR>", { desc = "quit window" })

-- DAP hover/preview
map({ "n", "v" }, "<Leader>dh", function()
  require("dap.ui.widgets").hover()
end, { desc = "debug hover info" })
map({ "n", "v" }, "<Leader>dp", function()
  require("dap.ui.widgets").preview()
end, { desc = "debug preview" })
map("n", "<Leader>df", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.frames)
end, { desc = "debug frames" })
map("n", "<Leader>ds", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end, { desc = "debug scopes" })

-- Disable arrow keys
map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Window navigation
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ Autocommands ]]

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Diagnostic keymaps ]]
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
-- <leader>q is already mapped above

-- [[ Helm filetype detection ]]
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*/templates/*.yaml", "*/templates/*.tpl" },
  callback = function()
    vim.bo.filetype = "helm"
  end,
})
