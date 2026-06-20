-- [[ LSP Configuration ]]
-- Uses native vim.lsp.config() + vim.lsp.enable() (Neovim 0.12+ API)
-- :help vim.lsp.config

-- ============================================================
-- fidget.nvim: LSP status updates
-- ============================================================
require('fidget').setup({
  notification = {
    window = { relative = 'win', winblend = 0, zindex = nil, border = 'none' },
  },
})

-- ============================================================
-- LspAttach: Keymaps and buffer-specific LSP settings
-- ============================================================
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
    map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
    map('<leader>D', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Document highlight
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local group = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf, group = group, callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf, group = group, callback = vim.lsp.buf.clear_references,
      })
    end

    -- Inlay hints toggle
    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

-- ============================================================
-- Diagnostic Configuration
-- ============================================================
vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
  virtual_text = {
    source = 'if_many',
    spacing = 2,
  },
})

-- ============================================================
-- Mason setup & LSP server configurations
-- ============================================================
require('mason').setup({})

-- LSP capabilities from cmp-nvim-lsp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

--- @type table<string, vim.lsp.Config>
local servers = {
  clangd = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  yamlls = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = 'Replace' },
        runtime = { version = 'LuaJIT' },
        diagnostics = { disable = { 'missing-fields' } },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file('', true),
        },
        telemetry = { enable = false },
      },
    },
  },
  helm_ls = {
    filetypes = { 'helm' },
    root_markers = { 'Chart.yaml', '.git' },
    settings = {
      ['helm-ls'] = { yamlls = { path = 'yaml-language-server' } },
    },
  },
}

-- Ensure LSP servers and tools are installed
local ensure_installed = vim.tbl_keys(servers)
vim.list_extend(ensure_installed, { 'stylua' })
require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

-- Configure and enable all servers using native 0.12 API
for name, config in pairs(servers) do
  config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end
