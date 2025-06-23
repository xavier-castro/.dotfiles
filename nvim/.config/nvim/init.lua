--[[
=====================================================================
██╗  ██╗██╗   ██╗██████╗ ██████╗ ██╗██████╗     ███╗   ██╗██╗   ██╗██╗███╗   ███╗
██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗██║██╔══██╗    ████╗  ██║██║   ██║██║████╗ ████║
███████║ ╚████╔╝ ██████╔╝██████╔╝██║██║  ██║    ██╔██╗ ██║██║   ██║██║██╔████╔██║
██╔══██║  ╚██╔╝  ██╔══██╗██╔══██╗██║██║  ██║    ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║  ██║   ██║   ██████╔╝██║  ██║██║██████╔╝    ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚═╝  ╚═╝╚═╝╚═════╝     ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝

NvChad + Kickstart.nvim Hybrid Configuration
=====================================================================

This configuration combines the best of both worlds:
- NvChad's beautiful UI, themes, and performance optimizations
- Kickstart.nvim's educational structure and transparency
- Full customizability while maintaining easy updates

Based on:
- NvChad v2.5: https://github.com/NvChad/NvChad
- Kickstart.nvim: https://github.com/nvim-lua/kickstart.nvim

=====================================================================
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
-- To check the current status of your plugins, run
--    :Lazy
--
-- To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require("lazy").setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  -- Here are some examples of different ways to use lazy:

  -- modular approach: using `require`
  { import = "plugins" },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
    border = "rounded",
  },
  performance = {
    rtp = {
      -- disable some rtp plugins for better performance
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- [[ Load core configuration modules ]]
-- These modules contain the basic Neovim configuration
require "config.options"
require "config.keymaps"
require "config.autocmds"

-- [[ NvChad Integration ]]
-- Load NvChad modules if available
local ok, nvchad_mappings = pcall(require, "nvchad.mappings")
if ok then
  -- Import some NvChad mappings that don't conflict
  local map = vim.keymap.set

  -- Theme picker from NvChad
  map("n", "<leader>th", function()
    require("nvchad.themes").open()
  end, { desc = "NvChad theme picker" })
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

