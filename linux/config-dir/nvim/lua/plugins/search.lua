-- Telescope search setup and mappings.

local telescope = require('telescope')
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
local map = vim.keymap.set

telescope.setup({
  defaults = {
    layout_config = { vertical = { width = 0.5 } },
    preview = { hide_on_startup = false },
  },
  extensions = {
    ['ui-select'] = { themes.get_dropdown() },
  },
})

pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'ui-select')

map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
map('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
map('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
map('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
map('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })

map('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(themes.get_dropdown({
    winblend = 0,
    previewer = true,
  }))
end, { desc = 'Fuzzily search in current buffer' })

map('n', '<leader>s/', function()
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  })
end, { desc = '[S]earch in open files' })

map('n', '<leader>sn', function()
  builtin.find_files({ cwd = vim.fn.stdpath('config') })
end, { desc = '[S]earch [N]eovim files' })
