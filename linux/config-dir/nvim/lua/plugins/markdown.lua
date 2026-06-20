-- Markdown plugins.

require('render-markdown').setup({
  file_types = { 'markdown', 'codecompanion' },
})

vim.g.mkdp_filetypes = { 'markdown' }
