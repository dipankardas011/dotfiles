-- Editor workflow plugins.

require('guess-indent').setup()

require('gitsigns').setup({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
})

require('which-key').setup({})
require('neogit').setup({})

require('snacks').setup({
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  explorer = { enabled = false },
  indent = { enabled = false },
  input = { enabled = false },
  picker = { enabled = false },
  notifier = { enabled = false },
  quickfile = { enabled = true },
  scope = { enabled = false },
  scroll = { enabled = false },
  statuscolumn = { enabled = true },
  words = { enabled = false },
})

require('nvim-lastplace').setup({
  lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
  lastplace_ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' },
  lastplace_open_folds = true,
})

require('todo-comments').setup({ signs = false })
require('colorizer').setup({ '!vim', '*' })
require('ibl').setup({ indent = { char = '┊' } })
require('nvim-autopairs').setup({})
