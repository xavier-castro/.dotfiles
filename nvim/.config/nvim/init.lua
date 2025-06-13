--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.g.have_nerd_font = false

-- Setup spell checking
require('xavier.spell').setup()

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'

require 'xavier.plugins.colors'
require 'xavier.plugins.mini'
require 'xavier.plugins.claude-code'
require 'xavier.plugins.git'
require 'xavier.plugins.trouble'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
