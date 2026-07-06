local function run_build(name, cmd, cwd)
  local result = vim.system(cmd, { cwd = cwd }):wait()
  if result.code == 0 then
    return
  end

  local output = (result.stderr or '') ~= '' and result.stderr or result.stdout
  vim.notify(('Build failed for %s:\n%s'):format(name, output ~= '' and output or 'No output'), vim.log.levels.ERROR)
end

vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('user-pack-build-hooks', { clear = true }),
  callback = function(ev)
    local name = ev.data.spec.name
    if ev.data.kind ~= 'install' and ev.data.kind ~= 'update' then
      return
    end

    if name == 'telescope-fzf-native.nvim' and vim.fn.executable('make') == 1 then
      run_build(name, { 'make' }, ev.data.path)
    elseif name == 'markdown-preview.nvim' then
      local app = ev.data.path .. '/app'
      if vim.fn.executable('yarn') == 1 then
        run_build(name, { 'yarn', 'install' }, app)
      elseif vim.fn.executable('npm') == 1 then
        run_build(name, { 'npm', 'install' }, app)
      else
        vim.notify('markdown-preview.nvim needs yarn or npm to install app dependencies', vim.log.levels.WARN)
      end
    end
  end,
})

vim.pack.add({
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
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/echasnovski/mini.nvim',
  'https://github.com/echasnovski/mini.icons',
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/romgrk/nvim-treesitter-context',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/iamcco/markdown-preview.nvim',
  'https://github.com/davidmh/mdx.nvim',
  'https://github.com/olimorris/codecompanion.nvim',
  'https://github.com/milanglacier/minuet-ai.nvim',
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/tpope/vim-dadbod',
  'https://github.com/kristijanhusak/vim-dadbod-completion',
  'https://github.com/kristijanhusak/vim-dadbod-ui',
  'https://github.com/fatih/vim-go',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
  'https://github.com/NvChad/nvterm',
  'https://github.com/sainnhe/everforest',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/saadparwaiz1/cmp_luasnip',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/onsails/lspkind.nvim',
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/leoluz/nvim-dap-go',
  'https://github.com/ldelossa/nvim-dap-projects',
}, { load = true })

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
  max_lines = '30%',
  multiline_threshold = 5,
  trim_scope = 'inner',
  patterns = {},
})

require('render-markdown').setup({ file_types = { 'markdown', 'codecompanion' } })
vim.g.mkdp_filetypes = { 'markdown' }
require('nvterm').setup()

local telescope = require('telescope')
telescope.setup({
  defaults = {
    layout_config = { vertical = { width = 0.5 } },
    preview = { hide_on_startup = false },
  },
  extensions = {
    ['ui-select'] = { require('telescope.themes').get_dropdown() },
  },
})
pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'ui-select')

local local_chat_model = 'gemma-4-E2B-it-Q4_K_M'

local function git_diff_for_commit_prompt()
  local staged = vim.system({ 'git', 'diff', '--no-ext-diff', '--staged' }, { text = true }):wait().stdout or ''
  if staged ~= '' then
    return staged
  end

  local unstaged = vim.system({ 'git', 'diff', '--no-ext-diff' }, { text = true }):wait().stdout or ''
  return unstaged ~= '' and unstaged or 'No staged or unstaged git diff found.'
end

require('codecompanion').setup({
  opts = { log_level = 'DEBUG' },
  display = { action_palette = { opts = { show_preset_prompts = false } } },
  adapters = {
    http = {
      gemma_local = function()
        return require('codecompanion.adapters').extend('openai_compatible', {
          env = {
            api_key = function()
              return 'hello'
            end,
            url = 'http://127.0.0.1:7000/v1',
            chat_url = '/chat/completions',
            models_endpoint = '/models',
          },
          opts = { stream = true, tools = false, vision = false },
          schema = {
            model = { default = local_chat_model, choices = { local_chat_model } },
            max_tokens = { default = 32768 },
          },
        })
      end,
    },
  },
  interactions = {
    chat = { adapter = { name = 'gemma_local', model = local_chat_model } },
    cmd = { adapter = { name = 'gemma_local', model = local_chat_model } },
  },
  prompt_library = {
    ['Commit message'] = {
      interaction = 'chat',
      description = 'Generate a commit message',
      opts = { alias = 'commit', is_slash_cmd = true, auto_submit = false },
      prompts = {
        {
          role = 'user',
          content = function()
            return table.concat({
              'You are an expert at following the Conventional Commit specification.',
              'Given the git diff listed below, generate a concise commit message.',
              'Wrap each line at 70 characters.',
              '',
              '```diff',
              git_diff_for_commit_prompt(),
              '```',
            }, '\n')
          end,
        },
      },
    },
  },
})

require('minuet').setup({
  provider = 'openai_fim_compatible',
  n_completions = 1,
  request_timeout = 3,
  throttle = 300,
  debounce = 150,
  context_window = 8000,
  context_ratio = 0.75,
  provider_options = {
    openai_fim_compatible = {
      api_key = 'TERM',
      name = 'vLLM-Qwen',
      end_point = 'http://127.0.0.1:8000/v1/completions',
      model = 'qwen2.5-coder',
      stream = true,
      template = {
        prompt = function(context_before_cursor, context_after_cursor, _)
          return '<|fim_prefix|>' .. context_before_cursor .. '<|fim_suffix|>' .. context_after_cursor .. '<|fim_middle|>'
        end,
        suffix = false,
      },
      optional = {
        max_tokens = 64,
        top_p = 0.9,
        temperature = 0.1,
        stop = { '<|im_end|>', '<|endoftext|>' },
      },
    },
  },
  virtualtext = {
    auto_trigger_ft = { 'go', 'lua', 'typescript', 'javascript', 'python', 'rust', 'terraform', 'bash', 'make', 'markdown', 'sh' },
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

require('lazydev').setup({
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
})

require('dapui').setup()
require('dap-go').setup({
  dap_configurations = {
    {
      type = 'go',
      name = 'For specific program',
      mode = 'remote',
      request = 'attach',
      program = '${file}',
      args = require('dap-go').get_arguments,
      buildFlags = require('dap-go').get_build_flags,
    },
    {
      type = 'go',
      name = 'Attach remote',
      mode = 'remote',
      request = 'attach',
      port = function()
        return tonumber(vim.fn.input('Port: ', '40404'))
      end,
    },
  },
  delve = { path = '/usr/bin/dlv', initialize_timeout_sec = 30 },
})

local dap = require('dap')
local dapui = require('dapui')
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
