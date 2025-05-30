--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Filetypes enable
require 'filetypes'

-- Autocommands
require 'custom.autocommands'

-- Extras
require 'custom.extras.terminal'
require 'custom.extras.big-file'
require 'custom.extras.quickfix'
require 'custom.extras.fuzzy-search'
require 'custom.extras.browser-search-bar'
require 'custom.extras.utils'

-- Undercurl Support
vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_Ce = "\e[4:0m"]]

vim.g.have_transparent_bg = true

-- Modern options from LazyVim
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 3
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

-- Nice and simple folding:
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldtext = ''
vim.opt.foldcolumn = '0'
vim.opt.fillchars:append { fold = ' ' }

-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.supports_method 'textDocument/foldingRange' then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})

-- File types
vim.filetype.add {
  extension = {
    mdx = 'mdx',
  },
}

-- Minimal diagnostics configuration
vim.diagnostic.config {
  signs = false, -- Disable sign column icons
  virtual_text = {
    spacing = 4,
    prefix = '●', -- Simple dot instead of icons
    severity = { min = vim.diagnostic.severity.WARN }, -- Only show warnings and errors
  },
  float = {
    border = 'rounded',
    source = 'if_many', -- Only show source if multiple sources
    header = '',
    prefix = '',
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

---- Spell
vim.opt.spell = false --> autocmd will enable spellcheck in Tex or markdown
vim.opt.spelllang = { 'en' }
vim.opt.spellsuggest = 'best,8' --> Suggest 8 words for spell suggestion
vim.opt.spelloptions = 'camel' --> Consider CamelCase when checking spelling

-- Indents
vim.opt.smarttab = true

-- No Wrap
vim.opt.wrap = false -- No Wrap lines

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true
-- relative numbers only in Normal mode and absolute numbers while typing
local autocmd = vim.api.nvim_create_autocmd -- define the helper *first*
local number_toggle = vim.api.nvim_create_augroup('number_toggle', { clear = true })
autocmd('InsertEnter', {
  group = number_toggle,
  callback = function()
    vim.opt.relativenumber = false
  end,
})

autocmd('InsertLeave', {
  group = number_toggle,
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- Move diagnostic location list under the <leader>e group
vim.keymap.set('n', '<leader>cel', vim.diagnostic.setloclist, { desc = 'Open diagnostic [L]ocation list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--  Uncomment the following line and add your keymaps to `lua/custom/keymaps/*.lua` to get going.
require 'custom.keymaps'
require 'custom.ghostty'

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- If you prefer to call `setup` explicitly, use:
  --    {
  --        'lewis6991/gitsigns.nvim',
  --        config = function()
  --            require('gitsigns').setup({
  --                -- Your gitsigns configuration here
  --            })
  --        end,
  --    }
  --
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`.
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      current_line_blame = true,
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      preset = 'helix',
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.opt.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          --
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>b', group = '[b]uffer' },
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename/[R]uby' },
        { '<leader>rt', group = '[R]uby [T]esting' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>W', group = '[W]orkspace' },
        { '<leader>w', group = '[W]indow' },
        { '<leader>T', group = '[T]oggle' },
        { '<leader>t', group = '[T]erminal' },
        { '<leader>x', group = 'Trouble/Diagnostics' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>gy', group = 'Git [Y]ank URL', mode = { 'n', 'v' } },
        -- File
        { '<leader>f', group = '[F]ile' },
        { '<leader>fe', group = '[E]dit' },
        --
        { '<leader>F', group = '[F]ormat' },
        { '<leader>q', group = '[Q]uit' },
        { '<leader>e', group = '[E]rror/Location' },

        -- 🔧 New non-leader mappings:
        { 'c', group = '[C]hange' },
        { 'd', group = '[D]elete' },
        { 'cs', desc = 'Change [S]urround' },
        { 'ds', desc = 'Delete [S]urround' },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin
  --

  -- Fuzzy Find
  require 'custom.plugins.telescope.init',

  -- Native LSP Config for Neovim 0.11+
  require 'lsp',

  {
    'EdenEast/nightfox.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      -- Default options
      require('nightfox').setup {
        options = {
          -- Compiled file's destination location
          compile_path = vim.fn.stdpath 'cache' .. '/nightfox',
          compile_file_suffix = '_compiled', -- Compiled file suffix
          transparent = false, -- Disable setting background
          terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
          dim_inactive = true, -- Non focused panes set to alternative background
          module_default = true, -- Default enable value for modules
          colorblind = {
            enable = false, -- Enable colorblind support
            simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
            severity = {
              protan = 0, -- Severity [0,1] for protan (red)
              deutan = 0, -- Severity [0,1] for deutan (green)
              tritan = 0, -- Severity [0,1] for tritan (blue)
            },
          },
          styles = { -- Style to be applied to different syntax groups
            comments = 'NONE', -- Value is any valid attr-list value `:help attr-list`
            conditionals = 'NONE',
            constants = 'NONE',
            functions = 'NONE',
            keywords = 'NONE',
            numbers = 'NONE',
            operators = 'NONE',
            strings = 'NONE',
            types = 'NONE',
            variables = 'NONE',
          },
          inverse = { -- Inverse highlight for different types
            match_paren = false,
            visual = false,
            search = false,
          },
          modules = { -- List of various plugins and additional options
            -- ...
          },
        },
        palettes = {},
        specs = {},
        groups = {},
      }

      -- setup must be called before loading
      vim.cmd 'colorscheme nightfox'
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'css',
        'go',
        'html',
        'html',
        'java',
        'javascript',
        'lua',
        'markdown',
        'markdown_inline',
        'python',
        'python',
        'rust',
        'toml',
        'vim',
        'vimdoc',
      }, -- put the language you want in this table
      -- ensure_installed = "all",
      sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
      ignore_install = {}, -- List of parsers to ignore installing
      highlight = {
        enable = true, -- false will disable the whole extension
        -- disable = function(_, bufnr) -- Disable in files with more than 10K lines
        --   return vim.api.nvim_buf_line_count(bufnr) > 10000
        -- end,
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      matchup = {
        enable = true,
      },
      indent = {
        enable = true,
        disable = function(lang, bufnr) -- Disable in files with more than 10K lines
          local langs = { 'html', 'cpp', 'css' }
          return vim.api.nvim_buf_line_count(bufnr) > 10000 or vim.tbl_contains(langs, lang)
        end,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = '<C-s>',
          node_decremental = '<M-space>',
        },
      },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- Rails development enhancements
  {
    'tpope/vim-rails',
    ft = { 'ruby', 'eruby', 'haml', 'slim' },
    cmd = {
      'Emodel',
      'Eview',
      'Econtroller',
      'Ehelper',
      'Einitializer',
      'Emigration',
      'Eschema',
    },
  },

  -- Add test runner for Ruby
  {
    'vim-test/vim-test',
    keys = {
      { '<leader>rt', '<cmd>TestFile<cr>', desc = '[R]uby [T]est File' },
      { '<leader>rs', '<cmd>TestNearest<cr>', desc = '[R]uby Test [S]ingle' },
      { '<leader>rl', '<cmd>TestLast<cr>', desc = '[R]uby Test [L]ast' },
      { '<leader>ra', '<cmd>TestSuite<cr>', desc = '[R]uby Test [A]ll' },
    },
    config = function()
      vim.g['test#strategy'] = 'neovim'
      vim.g['test#ruby#bundle_exec'] = 1
      vim.g['test#ruby#use_binstubs'] = 0
    end,
  },

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Custom UI modules
require('custom.ui.tabline').setup()
require('custom.ui.statusline-global').setup()
require('custom.ui.winbar').setup()

local set = vim.keymap.set

set('t', '<ESC><ESC>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

set('n', 'n', 'nzz')
set('n', 'N', 'Nzz')
set('n', '<C-u>', '<C-u>zz')
set('n', '<C-d>', '<C-d>zz')

-- Custom keymaps
set('i', 'jk', '<ESC>', { desc = 'Better ESC' })
set('i', '<C-s>', '<C-g>u<ESC>[s1z=`]a<C-g>u', { desc = 'Fix nearest [S]pelling error and put the cursor back' })

-- Copy and paste
set({ 'n', 'x' }, '<leader>a', 'gg<S-v>G', { desc = 'Select [A]ll' })
set('x', '<leader>y', '"+y', { desc = '[Y]ank to the system clipboard (+)' })
set(
  'x',
  '<leader>p',
  '"_dP', --> [d]elete the selection and send content to _ void reg then [P]aste (b4 cursor unlike small p)
  { desc = '[P]aste the current selection without overriding the register' }
)

-- Buffer
set('n', '[b', '<CMD>bprevious<CR>', { desc = 'Go to previous [B]uffer' })
set('n', ']b', '<CMD>bnext<CR>', { desc = 'Go to next [B]uffer' })
set(
  'n',
  '<leader>k',
  ":echo 'Choose a buf to delete (blank to choose curr)'<CR>" .. ':ls<CR>' .. ':bdelete<SPACE>',
  { silent = true, desc = '[K]ill a buffer' }
)

-- Terminal
-- Toggle-able floating terminal based on TJ DeVries's video
local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)
  -- Calculate the position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)
  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end
  -- Create the floating window
  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded',
  }
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

vim.api.nvim_create_user_command('Floaterminal', toggle_terminal, {})
set({ 'n', 't' }, '<leader>tt', toggle_terminal, { desc = '[T]oggle floating [T]erminal' })

--           | :top sp |
-- |:top vs| |:abo| cu | |:bot vs |
-- |       | |:bel| rr | |        |
--           | :bot sp |
-- botright == bot
set('n', '<leader>tb', function()
  vim.cmd('botright ' .. math.ceil(vim.fn.winheight(0) * 0.3) .. 'sp | term')
end, { desc = 'Launch a [T]erminal in the [B]ottom' })

set('n', '<leader>tr', function()
  vim.cmd('bot ' .. math.ceil(vim.fn.winwidth(0) * 0.3) .. 'vs | term')
end, { desc = 'Launch a [T]erminal to the [R]ight' })

--- Move to a window (one of hjkl) or create a split if a window does not exist in the direction.
--- Lua translation of:
--- https://www.reddit.com/r/vim/comments/166a3ij/comment/jyivcnl/?utm_source=share&utm_medium=web2x&context=3
--- Usage: vim.keymap("n", "<C-h>", function() move_or_create_win("h") end, {})
--
---@param key string One of h, j, k, l, a direction to move or create a split
local function smarter_win_nav(key)
  local fn = vim.fn
  local curr_win = fn.winnr()
  vim.cmd('wincmd ' .. key) --> attempt to move

  if curr_win == fn.winnr() then --> didn't move, so create a split
    if key == 'h' or key == 'l' then
      vim.cmd 'wincmd v'
    else
      vim.cmd 'wincmd s'
    end

    vim.cmd('wincmd ' .. key) --> move again
  end
end

set('n', '<C-h>', function()
  smarter_win_nav 'h'
end, { desc = 'Move focus to the left window or create a horizontal split' })
set('n', '<C-j>', function()
  smarter_win_nav 'j'
end, { desc = 'Move focus to the lower window or create a vertical split' })
set('n', '<C-k>', function()
  smarter_win_nav 'k'
end, { desc = 'Move focus to the upper window or create a vertical split' })
set('n', '<C-l>', function()
  smarter_win_nav 'l'
end, { desc = 'Move focus to the right window or create a horizontal split' })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
