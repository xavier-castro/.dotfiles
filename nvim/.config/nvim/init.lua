require('xavier.base')
require('xavier.highlights')
require('xavier.maps')
require('xavier.plugins')

local has = vim.fn.has
local is_mac = has "macunix"
local is_win = has "win32"

if is_mac then
  require('xavier.macos')
end
if is_win then
  require('xavier.windows')
end
