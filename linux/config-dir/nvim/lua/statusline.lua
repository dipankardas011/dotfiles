local M = {}

local modes = {
  ['n']      = { 'NORMAL', 'StatusNormal' },
  ['no']     = { 'N-PENDING', 'StatusNormal' },
  ['v']      = { 'VISUAL', 'StatusVisual' },
  ['V']      = { 'V-LINE', 'StatusVisual' },
  ['\22']    = { 'V-BLOCK', 'StatusVisual' },
  ['s']      = { 'SELECT', 'StatusSelect' },
  ['S']      = { 'S-LINE', 'StatusSelect' },
  ['\19']    = { 'S-BLOCK', 'StatusSelect' },
  ['i']      = { 'INSERT', 'StatusInsert' },
  ['ic']     = { 'INSERT', 'StatusInsert' },
  ['R']      = { 'REPLACE', 'StatusReplace' },
  ['Rv']     = { 'V-REPLACE', 'StatusReplace' },
  ['c']      = { 'COMMAND', 'StatusCommand' },
  ['cv']     = { 'V-EX', 'StatusCommand' },
  ['ce']     = { 'EX', 'StatusCommand' },
  ['r']      = { 'PROMPT', 'StatusNormal' },
  ['rm']     = { 'MORE', 'StatusNormal' },
  ['r?']     = { 'CONFIRM', 'StatusNormal' },
  ['!']      = { 'SHELL', 'StatusNormal' },
  ['t']      = { 'TERMINAL', 'StatusTerminal' },
}

local function get_git_branch()
  local dict = vim.b.gitsigns_status_dict
  if dict and dict.head and dict.head ~= '' then
    return '  ' .. dict.head .. ' '
  end
  return ''
end

local function get_diagnostics()
  local count = {
    [vim.diagnostic.severity.ERROR] = 0,
    [vim.diagnostic.severity.WARN] = 0,
    [vim.diagnostic.severity.INFO] = 0,
    [vim.diagnostic.severity.HINT] = 0,
  }
  
  local diagnostics = vim.diagnostic.get(0)
  for _, d in ipairs(diagnostics) do
    if count[d.severity] then
      count[d.severity] = count[d.severity] + 1
    end
  end
  
  local parts = {}
  if count[vim.diagnostic.severity.ERROR] > 0 then
    table.insert(parts, '%#StatusDiagnosticError#󰅚 ' .. count[vim.diagnostic.severity.ERROR])
  end
  if count[vim.diagnostic.severity.WARN] > 0 then
    table.insert(parts, '%#StatusDiagnosticWarn#󰀪 ' .. count[vim.diagnostic.severity.WARN])
  end
  if count[vim.diagnostic.severity.INFO] > 0 then
    table.insert(parts, '%#StatusDiagnosticInfo#󰋽 ' .. count[vim.diagnostic.severity.INFO])
  end
  if count[vim.diagnostic.severity.HINT] > 0 then
    table.insert(parts, '%#StatusDiagnosticHint#󰌶 ' .. count[vim.diagnostic.severity.HINT])
  end
  
  if #parts > 0 then
    return ' ' .. table.concat(parts, ' ') .. ' '
  end
  return ''
end

local function get_file_info()
  local file = vim.fn.expand('%:t')
  if file == '' then
    return ' [No Name] '
  end
  local modified = vim.bo.modified and ' 󰏫' or ''
  local readonly = vim.bo.readonly and ' 󰌾' or ''
  return ' ' .. file .. modified .. readonly .. ' '
end

function M.setup()
  -- Define highlights dynamically on ColorScheme change
  local function set_highlights()
    -- Normal mode (Green)
    vim.api.nvim_set_hl(0, 'StatusNormal', { fg = '#1e2326', bg = '#a7c080', bold = true })
    -- Insert mode (Blue)
    vim.api.nvim_set_hl(0, 'StatusInsert', { fg = '#1e2326', bg = '#7fbbb3', bold = true })
    -- Visual mode (Purple)
    vim.api.nvim_set_hl(0, 'StatusVisual', { fg = '#1e2326', bg = '#d699b6', bold = true })
    -- Replace mode (Red)
    vim.api.nvim_set_hl(0, 'StatusReplace', { fg = '#1e2326', bg = '#e67e80', bold = true })
    -- Command mode (Yellow)
    vim.api.nvim_set_hl(0, 'StatusCommand', { fg = '#1e2326', bg = '#dbbc7f', bold = true })
    -- Terminal mode (Aqua)
    vim.api.nvim_set_hl(0, 'StatusTerminal', { fg = '#1e2326', bg = '#83c092', bold = true })
    -- Select mode (Orange)
    vim.api.nvim_set_hl(0, 'StatusSelect', { fg = '#1e2326', bg = '#f57f17', bold = true })

    -- Rest of statusline segments
    vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#d3c6aa', bg = '#2d353b' })
    vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#859289', bg = '#232a2e' })
    vim.api.nvim_set_hl(0, 'StatusGit', { fg = '#a7c080', bg = '#3d484d', bold = true })
    vim.api.nvim_set_hl(0, 'StatusFile', { fg = '#d3c6aa', bg = '#3d484d' })
    vim.api.nvim_set_hl(0, 'StatusLocation', { fg = '#1e2326', bg = '#d3c6aa', bold = true })

    -- Diagnostic highlights
    vim.api.nvim_set_hl(0, 'StatusDiagnosticError', { fg = '#e67e80', bg = '#2d353b', bold = true })
    vim.api.nvim_set_hl(0, 'StatusDiagnosticWarn', { fg = '#dbbc7f', bg = '#2d353b', bold = true })
    vim.api.nvim_set_hl(0, 'StatusDiagnosticInfo', { fg = '#7fbbb3', bg = '#2d353b', bold = true })
    vim.api.nvim_set_hl(0, 'StatusDiagnosticHint', { fg = '#83c092', bg = '#2d353b', bold = true })
  end

  set_highlights()

  vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('statusline-highlights', { clear = true }),
    callback = set_highlights,
  })

  -- Set statusline
  _G.my_statusline = function()
    local mode_info = modes[vim.api.nvim_get_mode().mode] or { 'NORMAL', 'StatusNormal' }
    local mode_text = ' ' .. mode_info[1] .. ' '
    local mode_hl = '%#' .. mode_info[2] .. '#'
    
    local git = get_git_branch()
    local git_hl = git ~= '' and '%#StatusGit#' or ''
    
    local file = get_file_info()
    local file_hl = '%#StatusFile#'
    
    local diagnostics = get_diagnostics()
    
    -- Left side
    local left = mode_hl .. mode_text .. git_hl .. git .. file_hl .. file .. '%#StatusLine#'
    
    -- Middle spacer
    local middle = '%='
    
    -- Right side
    local right_location = '%#StatusLocation# %l:%c '
    
    return left .. middle .. diagnostics .. right_location
  end

  vim.opt.statusline = '%!v:lua.my_statusline()'
end

return M
