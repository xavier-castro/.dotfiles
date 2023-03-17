local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

local wk = require("which-key")

wk.register({
["<C-e>"] = {ui.toggle_quick_menu, "Toggle Quick Menu"},
["<C-h>"] = {function() ui.nav_file(1) end, "Nav to file 1"},
["<C-j>"] = {function() ui.nav_file(2) end, "Nav to file 2"},
["<C-k>"] = {function() ui.nav_file(3) end, "Nav to file 3"},
["<C-l>"] = {function() ui.nav_file(4) end, "Nav to file 4"},
})

wk.register({
a = {mark.add_file, "Harpoon Add File"},
}, {prefix="<leader>"})

