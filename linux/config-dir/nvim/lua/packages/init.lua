-- Native package management with vim.pack.

require('packages.build').setup()

vim.pack.add(require('packages.spec'), { load = true })
