vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.have_transparent_bg = true

-- PLUGIN MANAGER
require("helpers.init")
require("config.lazy")
require("config.options")
require("config.remaps")
require("config.autocommands")
