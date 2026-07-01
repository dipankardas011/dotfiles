-- AI/code-assistance plugins.

local local_chat_model = 'gemma-4-E2B-it-Q4_K_M'

local function git_diff_for_commit_prompt()
  local staged = vim.system({ 'git', 'diff', '--no-ext-diff', '--staged' }, { text = true }):wait().stdout or ''
  if staged ~= '' then
    return staged
  end

  local unstaged = vim.system({ 'git', 'diff', '--no-ext-diff' }, { text = true }):wait().stdout or ''
  if unstaged ~= '' then
    return unstaged
  end

  return 'No staged or unstaged git diff found.'
end

require('codecompanion').setup({
  opts = { log_level = 'DEBUG' },
  display = {
    action_palette = {
      opts = {
        -- Avoid parsing CodeCompanion's built-in markdown prompt library.
        -- /commit is defined below as Lua to keep this config treesitter-free.
        show_preset_prompts = false,
      },
    },
  },
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
            model = {
              default = local_chat_model,
              choices = { local_chat_model },
            },
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
      opts = {
        alias = 'commit',
        is_slash_cmd = true,
        auto_submit = false,
      },
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
          return '<|fim_prefix|>'
            .. context_before_cursor
            .. '<|fim_suffix|>'
            .. context_after_cursor
            .. '<|fim_middle|>'
        end,
        suffix = false, -- vLLM doesn't support the suffix param
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
    auto_trigger_ft = {
      'go',
      'lua',
      'typescript',
      'javascript',
      'python',
      'rust',
      'terraform',
      'bash',
      'make',
      'markdown',
    },
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
