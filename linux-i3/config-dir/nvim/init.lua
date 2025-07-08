-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- -- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    "NvChad/nvterm",
    config = function ()
      require("nvterm").setup()
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      -- OR setup with some options
      require("colorizer").setup({
        '!vim'; -- Exclude vim from highlighting.
        '*';
      })
    end,

  },
  {
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-completion",
    "kristijanhusak/vim-dadbod-ui",
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- add any opts here
      -- for example
      provider = "copilot",
      mode = "agentic",
      hints = { enabled = false },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  -- {
  --   'romgrk/barbar.nvim',
  --   dependencies = {
  --     'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
  --     'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  --   },
  --   init = function()
  --     vim.g.barbar_auto_setup = true
  --   end,
  -- },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- Required for Job and HTTP requests
    },
    -- uncomment the following line to load hub lazily
    --cmd = "MCPHub",  -- lazy load 
    build = "npm install -g mcp-hub@latest",  -- Installs required mcp-hub npm module
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
    -- build = "bundled_build.lua",  -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    config = function()
      require("mcphub").setup()
    end,
  },
  -- {  -- New on screen popup
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     -- add any options here
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- -- OPTIONAL:
  --     -- --   `nvim-notify` is only needed, if you want to use the notification view.
  --     -- --   If not available, we use `mini` as the fallback
  --     -- "rcarriga/nvim-notify",
  --   }
  -- },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
    },
    config = function ()
      require("codecompanion").setup({
        opts = {
          log_level = "DEBUG", -- or "TRACE"
        }
      })
    end
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function ()
      require("copilot_cmp").setup()
    end
  },
  {
    "sainnhe/everforest",
    config = function()
      vim.g.everforest_diagnostic_text_highlight=1
      vim.g.everforest_diagnostic_line_highlight=1
      vim.g.everforest_transparent_background=1
      vim.g.everforest_diagnostic_virtual_text='highlighted'
      vim.g.everforest_background='hard'
      -- vim.g.everforest_dim_inactive_windows=1
      vim.g.everforest_ui_contrast='high'
      vim.g.everforest_current_word='underline'

      vim.g.everforest_better_performance=1
      vim.g.everforest_enable_italic=1
      vim.g.everforest_cursor='aqua'
      vim.g.everforest_inlay_hints_background='dimmed'
      vim.cmd.colorscheme 'everforest'
      vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#7fbbb3', bold = true })
    end,
  },

  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      -- OR setup with some options
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          -- width = 30,
          float = {
            enable = true,
            quit_on_focus_loss = true,
            open_win_config = {
              relative = "editor",
              col = vim.api.nvim_win_get_width(0),
              row = vim.api.nvim_win_get_height(0),
              border = "rounded",
              width = 40,
              height = 30,
              -- row = 1,
              -- col = 1,
            },
          },
        },
        renderer = {
          group_empty = true,
          icons = {
            webdev_colors = true,
            git_placement = "before",
            modified_placement = "after",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
              modified = true,
            },
            glyphs = {
              default = "",
              symlink = "",
              bookmark = "󰆤",
              modified = "●",
              folder = {
                arrow_closed = "",
                arrow_open = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
        filters = {
          dotfiles = false,
        },
      })
    end
  },
  {
    "maxandron/goplements.nvim",
    ft = "go",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  -- {
  --   "startup-nvim/startup.nvim",
  --   requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
  --   config = function()
  --     require "startup".setup({
  --       theme = "dashboard", -- Example theme, customize as needed
  --     })
  --   end
  -- },
  {
    'nvim-tree/nvim-web-devicons',
  },

  "fatih/vim-go",

  {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup({})
    end
  },

  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup{
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          -- default = {
          --     'class',
          --     'function',
          --     'method',
          -- },
        },
      }
    end
  },

  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit", "gitrebase", "svn", "hgcommit",
        },
        lastplace_open_folds = true,
      })
    end,
  },

  -- dlv debug --headless --listen=:40404 --api-version=2 --redirect="stdin:/dev/stdin" --redirect="stdout:/dev/stdout" --redirect="stderr:/dev/stderr" -- cluster create
  {
    "leoluz/nvim-dap-go",
    config = function()
      require("dap-go").setup({
        dap_configurations = {
          {
            type = "go",
            name = "For specific program",
            mode = "remote",
            request = "attach",
            program = "${file}",
            args = require("dap-go").get_arguments,
            buildFlags = require("dap-go").get_build_flags,
          },
          {
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
            port = function()
              return tonumber(vim.fn.input('Port: ', '40404'))
            end,
          },
        },
        delve = {
          path = "/home/dipankar/go/bin/dlv",
          initialize_timeout_sec = 30,
          -- args = dap_go.get_arguments,
          -- build_flags = dap_go.get_build_flags,
        },
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  "ldelossa/nvim-dap-projects",

  'mfussenegger/nvim-dap',

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function ()
      require("dapui").setup()
    end
  },

  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {
        window = {
          relative = "win",         -- where to anchor, either "win" or "editor"
          blend = 0,              -- &winblend for the window
          zindex = nil,             -- the zindex value for the window
          border = "none",          -- style of border for the fidget window
        },
      } },

      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      'hrsh7th/cmp-nvim-lsp',

      'rafamadriz/friendly-snippets',
    },
  },

  { 'folke/which-key.nvim', opts = {} },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },


  -- {
  --   'nvim-lualine/lualine.nvim',
  --   opts = {
  --     options = {
  --       icons_enabled = true,
  --       -- theme = 'auto', -- or your colorscheme like 'tokyonight', 'catppuccin', etc.
  --       theme = 'auto',
  --       section_separators = { left = ' ', right = ' ' },
  --       disabled_filetypes = {},
  --       globalstatus = true,
  --     },
  --     sections = {
  --       lualine_a = {
  --         {
  --           'mode',
  --           separator = { left = '', right = ' ' },
  --           right_padding = 2,
  --         },
  --       },
  --       lualine_b = {
  --         {
  --           'branch',
  --           icon = '',
  --           separator = { left = ' ', right = ' ' },
  --           right_padding = 2,
  --         },
  --         {
  --           'diff',
  --           symbols = { added = ' ', modified = ' ', removed = ' ' },
  --           separator = { left = ' ', right = ' ' },
  --         },
  --         {
  --           'diagnostics',
  --           sources = { 'nvim_diagnostic' },
  --           symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
  --           separator = { left = ' ', right = ' ' },
  --         },
  --       },
  --       lualine_c = {
  --         {
  --           'filename',
  --           path = 1,
  --           separator = { left = '', right = ' ' },
  --           color = { bg = '#2c2e34' }, -- Match your lualine background color
  --         }
  --       },
  --       lualine_x = {
  --         {
  --           'encoding',
  --           separator = { left = ' ', right = ' ' },
  --         },
  --         {
  --           'fileformat',
  --           symbols = {
  --             unix = '', -- LF
  --             dos = '',  -- CRLF
  --             mac = '',  -- CR
  --           },
  --           separator = { left = ' ', right = ' ' },
  --         },
  --         {
  --           'filetype',
  --           icon_only = false,
  --           separator = { left = ' ', right = ' ' },
  --         },
  --       },
  --       lualine_y = {
  --         {
  --           'progress',
  --           separator = { left = ' ', right = ' ' },
  --         },
  --       },
  --       lualine_z = {
  --         {
  --           'location',
  --           separator = { left = '', right = '' },
  --           left_padding = 2,
  --         },
  --       },
  --     },
  --     inactive_sections = {
  --       lualine_a = {},
  --       lualine_b = {},
  --       lualine_c = { 'filename' },
  --       lualine_x = { 'location' },
  --       lualine_y = {},
  --       lualine_z = {}
  --     },
  --     tabline = {},
  --     extensions = {}
  --   },
  -- },
  --
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function ()
      require("ibl").setup({
        indent = { char = '┊'},
      })
    end,
  },

  { 'numToStr/Comment.nvim', opts = {} },
  -- {
  --   "sphamba/smear-cursor.nvim",
  --   opts = {
  --     cursor_color = "#7fbbb3",
  --   },
  -- },
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' },
    -- remove preview
    config = function()
      require('telescope').setup {
        defaults = {
          layout_config = {
            horizontal = { width = 0.5 },
            vertical = { width = 0.5 }
          },
          -- Disable the previewer
          preview = { hide_on_startup = true },
        },
      }
    end
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },
})


-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'


-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

vim.o.scrolloff = 2

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- tabs
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.numberwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

vim.wo.relativenumber = true

vim.wo.wrap = true

vim.wo.cursorline = true


-- vim.wo.spell = true

vim.opt.colorcolumn = "100"

vim.opt.statusline = ' %{mode()}%=%<%f%=%y %l,%c '


vim.o.laststatus = 3 -- global status


-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', '<leader>b', ":NvimTreeToggle<CR>", {desc = "toggle nvimtree"})

--- for the nvim-terminal
vim.keymap.set({'n', 't'}, '<A-h>', function () require("nvterm.terminal").toggle('horizontal') end, { desc = '[A]ctivate terminal [H]orizontal' })
vim.keymap.set({'n', 't'}, '<A-v>', function () require("nvterm.terminal").toggle('vertical') end, { desc = '[A]ctivate terminal [V]ertical' })
vim.keymap.set({'n', 't'}, '<A-i>', function () require("nvterm.terminal").toggle('float') end, { desc = '[A]ctivate terminal [I]Floating' })

vim.keymap.set('n', '<C-Tab>', ':bdelete<CR>',{ desc = 'close buffer' })
vim.keymap.set('n', '<Tab>', ':bnext<CR>',{ desc = 'next buffer' })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>',{ desc = 'prev buffer' })
vim.keymap.set('n', '<Leader>t', ':tabnew<CR>',{ desc = 'new tab' })

vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'Go debug CONTINUE' })
vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end, { desc = '[D]ebug [b]reakpoint' })
vim.keymap.set('n', '<Leader>dU', function() require('dapui').toggle() end, { desc = '[D]ebug [U]UI toggle' })
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = '[l]log pointer for debug' })

vim.keymap.set('n', '<leader>gsp', ':Git add -p .<CR>',{ desc = 'Git add with prompt' })
vim.keymap.set('n', '<leader>gsa', ':Git add .<CR>',{ desc = 'Git add all' })
vim.keymap.set('n', '<leader>gcs', ':Git commit -sv<CR>',{ desc = 'git commit with sign' })
vim.keymap.set('n', '<leader>aigc', ':CopilotChatCommit<CR>',{ desc = 'generate commit message' })
vim.keymap.set('n', '<leader>ai', ':CodeCompanionChat<CR>',{ desc = 'Get AI Chat' })



-- for moving the selected code
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")

-- allows the search terms to stay in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- make the selected copy to selecte paste to work 
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set('n','<C-s>', ':w<CR>', {desc = 'Save the file'})
vim.keymap.set('n','<C-q>', ':bdelete<CR>', {desc = 'quit window'})


vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end, {desc = 'debug hover info'})
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    -- winblend = 10,
    previewer = true,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', function()
  require('telescope.builtin').find_files({
    hidden = true, -- Show hidden files
    prompt_title = '[S]earch [F]iles', -- Set prompt title
  })
end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim', 'python', 'html', 'css' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,
  sync_install = false,
  ignore_install = {},
  modules = {},

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  vim.keymap.set('i','<C-k>', vim.lsp.buf.signature_help)

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')


  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
  vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Document Highlight",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Clear All the References",
    })
  end

end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.

local servers = {
  clangd = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  yamlls = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
  automatic_installation = true,
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
