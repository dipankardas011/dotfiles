-- Build hooks for plugins managed by vim.pack.

local M = {}

local function run_build(name, cmd, cwd)
  local result = vim.system(cmd, { cwd = cwd }):wait()
  if result.code == 0 then
    return
  end

  local output = (result.stderr or '') ~= '' and result.stderr or result.stdout
  if output == '' then
    output = 'No output from build command.'
  end

  vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
end

function M.setup()
  vim.api.nvim_create_autocmd('PackChanged', {
    group = vim.api.nvim_create_augroup('user-pack-build-hooks', { clear = true }),
    callback = function(ev)
      local name = ev.data.spec.name
      local kind = ev.data.kind

      if kind ~= 'install' and kind ~= 'update' then
        return
      end

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
      end
    end,
  })
end

return M
