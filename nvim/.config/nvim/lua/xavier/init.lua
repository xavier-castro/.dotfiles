require("xavier.globals")
require("xavier.set")
require("xavier.remap")
-- Lazy must be loaded before autocmds so the 'is_available'
-- function can work properly.
require("xavier.lazy")
require("xavier.autocmds")
