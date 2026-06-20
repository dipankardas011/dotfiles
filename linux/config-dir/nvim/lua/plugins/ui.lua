-- UI plugins.

require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

require('oil').setup({
  columns = { 'icon' },
  float = {
    border = 'none',
    max_width = 0.5,
    max_height = 0.5,
    preview_split = 'right',
  },
  view_options = { show_hidden = true },
})

require('mini.tabline').setup()
require('mini.statusline').setup({ use_icons = vim.g.have_nerd_font })

require('treesitter-context').setup({
  enable = true,
  throttle = true,
  max_lines = 0,
  patterns = {},
})
