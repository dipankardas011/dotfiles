-- Global keymaps.

local map = vim.keymap.set

map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Tab navigation with Alt+number.
for i = 1, 9 do
  map('n', '<A-' .. i .. '>', i .. 'gt', { noremap = true, silent = true })
end

-- Better movement with wrapped lines.
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- File explorer.
map('n', '<leader>b', '<cmd>Oil --float<CR>', { desc = 'Open Oil file explorer' })

-- Terminal toggles.
map({ 'n', 't' }, '<A-h>', function()
  require('nvterm.terminal').toggle('horizontal')
end, { desc = '[A]ctivate terminal [H]orizontal' })

map({ 'n', 't' }, '<A-v>', function()
  require('nvterm.terminal').toggle('vertical')
end, { desc = '[A]ctivate terminal [V]ertical' })

map({ 'n', 't' }, '<A-i>', function()
  require('nvterm.terminal').toggle('float')
end, { desc = '[A]ctivate terminal Float' })

-- Buffers / tabs.
map('n', '<C-Tab>', '<cmd>bdelete<CR>', { desc = 'Close buffer' })
map('n', '<Tab>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
map('n', '<S-Tab>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
map('n', '<Leader>t', '<cmd>tabnew<CR>', { desc = 'New tab' })

-- Debugging.
map('n', '<F5>', function()
  require('dap').continue()
end, { desc = 'Debug: continue' })

map('n', '<Leader>db', function()
  require('dap').toggle_breakpoint()
end, { desc = '[D]ebug [B]reakpoint' })

map('n', '<Leader>dU', function()
  require('dapui').toggle()
end, { desc = '[D]ebug UI toggle' })

map('n', '<Leader>lp', function()
  require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end, { desc = '[L]og [P]oint for debug' })

map({ 'n', 'v' }, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end, { desc = 'Debug hover info' })

map({ 'n', 'v' }, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end, { desc = 'Debug preview' })

map('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end, { desc = 'Debug frames' })

map('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end, { desc = 'Debug scopes' })

-- Git / AI.
map('n', '<leader>gg', '<cmd>Neogit<CR>', { desc = 'Show Neogit UI' })
map('n', '<leader>gsp', '<cmd>Git add -p .<CR>', { desc = 'Git add with prompt' })
map('n', '<leader>gsa', '<cmd>Git add .<CR>', { desc = 'Git add all' })
map('n', '<leader>gcs', '<cmd>Git commit -sv<CR>', { desc = 'Git commit with signoff' })
map('n', '<leader>aigc', '<cmd>CodeCompanion /commit<CR>', { desc = 'Generate commit message' })
map('n', '<leader>ai', '<cmd>CodeCompanionChat<CR>', { desc = 'Open AI chat' })

-- Editing helpers.
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('x', '<leader>p', '"_dP')

-- Save / quit.
map('n', '<C-s>', '<cmd>w<CR>', { desc = 'Save file' })
map('n', '<C-q>', '<cmd>bdelete<CR>', { desc = 'Close buffer' })

-- Disable arrow keys.
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Window navigation.
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Diagnostics.
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
