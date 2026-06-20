-- Plugin setup entrypoint.
-- Package installation is handled in lua/packages/.

local modules = {
  'plugins.editor',
  'plugins.ui',
  'plugins.markdown',
  'plugins.ai',
  'plugins.search',
  'plugins.terminal',
  'plugins.colorscheme',
}

for _, module in ipairs(modules) do
  require(module)
end
