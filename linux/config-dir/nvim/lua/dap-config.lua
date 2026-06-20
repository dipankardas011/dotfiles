-- [[ Debug Adapter Protocol Configuration ]]
-- Requires: mfussenegger/nvim-dap, rcarriga/nvim-dap-ui, leoluz/nvim-dap-go, ldelossa/nvim-dap-projects

-- nvim-dap-ui setup
require('dapui').setup()

-- nvim-dap-go setup
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
  delve = {
    path = '/usr/bin/dlv',
    initialize_timeout_sec = 30,
  },
})

-- nvim-dap-projects (no config needed)

-- Auto-open dap-ui when debug session starts
local dap = require('dap')
local dapui = require('dapui')
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
