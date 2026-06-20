-- [[ Plugin management and configuration ]]
-- Uses vim.pack (built-in Neovim 0.12+ plugin manager)
-- See :help vim.pack

-- ============================================================
-- Build hook for plugins that need compilation
-- ============================================================
local function run_build(name, cmd, cwd)
  local result = vim.system(cmd, { cwd = cwd }):wait()
  if result.code ~= 0 then
    local output = (result.stderr or '') ~= '' and result.stderr or result.stdout
    if output == '' then output = 'No output from build command.' end
    vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
  end
end

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end

    if name == 'telescope-fzf-native.nvim' and vim.fn.executable('make') == 1 then
      run_build(name, { 'make' }, ev.data.path)
      return
    end

    if name == 'markdown-preview.nvim' then
      local app = ev.data.path .. '/app'
      if vim.fn.executable('yarn') == 1 then
        run_build(name, { 'yarn', 'install' }, app)
      elseif vim.fn.executable('npm') == 1 then
        run_build(name, { 'npm', 'install' }, app)
      else
        vim.notify('markdown-preview.nvim needs yarn or npm to install app dependencies', vim.log.levels.WARN)
      end
      return
    end
  end,
})

-- ============================================================
-- Install ALL plugins in a single batch (parallel install)
-- ============================================================
vim.pack.add({
  -- Git / Editor
  'https://github.com/NMAC427/guess-indent.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/NeogitOrg/neogit',
  'https://github.com/sindrets/diffview.nvim',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/nvim-mini/mini.pick',
  'https://github.com/folke/snacks.nvim',
  'https://github.com/ethanholz/nvim-lastplace',
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/catgoose/nvim-colorizer.lua',
  'https://github.com/lukas-reineke/indent-blankline.nvim',

  -- UI / File Explorer
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/echasnovski/mini.nvim',
  'https://github.com/echasnovski/mini.icons',
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/romgrk/nvim-treesitter-context',

  -- Markdown
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/iamcco/markdown-preview.nvim',
  'https://github.com/davidmh/mdx.nvim',

  -- AI / Code Assistance
  'https://github.com/olimorris/codecompanion.nvim',
  'https://github.com/milanglacier/minuet-ai.nvim',
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/nvim-lua/plenary.nvim',

  -- Database
  'https://github.com/tpope/vim-dadbod',
  'https://github.com/kristijanhusak/vim-dadbod-completion',
  'https://github.com/kristijanhusak/vim-dadbod-ui',

  -- Go
  'https://github.com/fatih/vim-go',

  -- Telescope
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',

  -- Terminal
  'https://github.com/NvChad/nvterm',

  -- Colorscheme
  'https://github.com/sainnhe/everforest',

  -- LSP / Mason (needed by lsp.lua)
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  'https://github.com/j-hui/fidget.nvim',


  -- Completion
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/saadparwaiz1/cmp_luasnip',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/onsails/lspkind.nvim',

  -- DAP
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/leoluz/nvim-dap-go',
  'https://github.com/ldelossa/nvim-dap-projects',

}, { load = true })

-- ============================================================
-- Plugin configurations
-- ============================================================

-- guess-indent.nvim
require('guess-indent').setup()

-- gitsigns.nvim
require('gitsigns').setup({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
})

-- which-key.nvim
require('which-key').setup({})

-- neogit
require('neogit').setup({})
vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<CR>', { desc = 'Show Neogit UI' })

-- snacks.nvim
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

-- nvim-lastplace
require('nvim-lastplace').setup({
  lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
  lastplace_ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' },
  lastplace_open_folds = true,
})

-- todo-comments.nvim
require('todo-comments').setup({ signs = false })

-- nvim-colorizer.lua
require('colorizer').setup({ '!vim', '*' })

-- indent-blankline.nvim
require('ibl').setup({ indent = { char = '┊' } })

-- mini.icons: icon provider for Oil/Telescope/etc.
require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

-- oil.nvim
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

-- mini.nvim (tabline + statusline)
require('mini.tabline').setup()
local statusline = require('mini.statusline')
statusline.setup({ use_icons = vim.g.have_nerd_font })

-- nvim-autopairs
require('nvim-autopairs').setup({})

-- nvim-treesitter-context
require('treesitter-context').setup({
  enable = true,
  throttle = true,
  max_lines = 0,
  patterns = {},
})

-- render-markdown.nvim
require('render-markdown').setup({
  file_types = { 'markdown', 'codecompanion' },
})

-- markdown-preview.nvim
vim.g.mkdp_filetypes = { 'markdown' }

-- codecompanion.nvim
require('codecompanion').setup({
  opts = { log_level = 'DEBUG' },
  display = {
    action_palette = {
      opts = {
        -- Avoid parsing CodeCompanion's built-in markdown prompt library.
        -- We define /commit below as a Lua prompt to keep the config treesitter-free.
        show_preset_prompts = false,
      },
    },
  },
  adapters = {
    http = {
      gemma_local = function()
        return require('codecompanion.adapters').extend('openai_compatible', {
          env = {
            api_key = function() return 'hello' end,
            url = 'http://127.0.0.1:7000/v1',
            chat_url = '/chat/completions',
            models_endpoint = '/models',
          },
          opts = { stream = true, tools = false, vision = false },
          schema = {
            model = {
              default = 'gemma-4-E2B-it-Q4_K_M',
              choices = { 'gemma-4-E2B-it-Q4_K_M' },
            },
            max_tokens = { default = 32768 },
          },
        })
      end,
    },
  },
  interactions = {
    chat = { adapter = { name = 'gemma_local', model = 'gemma-4-E2B-it-Q4_K_M' } },
    cmd = { adapter = { name = 'gemma_local', model = 'gemma-4-E2B-it-Q4_K_M' } },
  },
  prompt_library = {
    ['Commit message'] = {
      interaction = 'chat',
      description = 'Generate a commit message',
      opts = {
        alias = 'commit',
        is_slash_cmd = true,
        auto_submit = false,
      },
      prompts = {
        {
          role = 'user',
          content = function()
            local staged = vim.system({ 'git', 'diff', '--no-ext-diff', '--staged' }, { text = true }):wait().stdout or ''
            local diff = staged
            if diff == '' then
              diff = vim.system({ 'git', 'diff', '--no-ext-diff' }, { text = true }):wait().stdout or ''
            end
            if diff == '' then
              diff = 'No staged or unstaged git diff found.'
            end

            return table.concat({
              'You are an expert at following the Conventional Commit specification.',
              'Given the git diff listed below, generate a concise commit message. with 70 characters everyline.',
              '',
              '```diff',
              diff,
              '```',
            }, '\n')
          end,
        },
      },
    },
  },
})

-- minuet-ai.nvim
require('minuet').setup({
  provider = 'openai_fim_compatible',
  n_completions = 1,
  request_timeout = 3,
  throttle = 300,
  debounce = 150,
  context_window = 6000,
  context_ratio = 0.75,
  provider_options = {
    openai_fim_compatible = {
      api_key = 'TERM',
      name = 'Llama.cpp',
      end_point = 'http://127.0.0.1:6969/v1/completions',
      model = 'Qwen2.5-Coder-1.5B',
      stream = true,
      optional = {
        max_tokens = 64,
        top_p = 0.9,
        temperature = 0.1,
        stop = { '<|im_end|>', '<|endoftext|>' },
      },
    },
  },
  virtualtext = {
    auto_trigger_ft = { 'go', 'lua', 'typescript', 'javascript', 'python', 'rust', 'terraform', 'bash', 'make', 'markdown' },
    show_on_completion_menu = true,
    keymap = {
      accept = '<A-A>',
      accept_line = '<A-a>',
      accept_n_lines = '<A-z>',
      prev = '<A-[>',
      next = '<A-]>',
      dismiss = '<A-e>',
    },
  },
})

-- lazydev.nvim
require('lazydev').setup({
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
})

-- telescope.nvim
require('telescope').setup({
  defaults = {
    layout_config = { vertical = { width = 0.5 } },
    preview = { hide_on_startup = false },
  },
  extensions = {
    ['ui-select'] = { require('telescope.themes').get_dropdown() },
  },
})

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

-- Telescope keymaps
local builtin = require('telescope.builtin')
local map = vim.keymap.set
map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
map('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
map('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
map('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
map('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
map('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
    winblend = 0,
    previewer = true,
  }))
end, { desc = '[/] Fuzzily search in current buffer' })
map('n', '<leader>s/', function()
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  })
end, { desc = '[S]earch [/] in Open Files' })
map('n', '<leader>sn', function()
  builtin.find_files({ cwd = vim.fn.stdpath('config') })
end, { desc = '[S]earch [N]eovim files' })

-- nvterm
require('nvterm').setup()

-- everforest colorscheme
vim.g.everforest_diagnostic_text_highlight = 1
vim.g.everforest_diagnostic_line_highlight = 1
vim.g.everforest_transparent_background = 1
vim.g.everforest_diagnostic_virtual_text = 'highlighted'
vim.g.everforest_background = 'hard'
vim.g.everforest_dim_inactive_windows = 1
vim.g.everforest_ui_contrast = 'high'
vim.g.everforest_current_word = 'underline'
vim.g.everforest_better_performance = 1
vim.g.everforest_enable_italic = 1
vim.g.everforest_inlay_hints_background = 'dimmed'
vim.cmd.colorscheme('everforest')
