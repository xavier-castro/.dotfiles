local M = {}

local defaults = {
	defaults = {
		keymaps = require("xavier.config.keymaps"),
		options = require("xavier.config.options"),
	},
}

local options

function M.setup(opts)
 options = vim.tbl_deep_extend("force", defaults, opts or {})
	  if vim.fn.argc(-1) == 0 then
    -- autocmds and keymaps can wait to load
    vim.api.nvim_create_autocmd("User", {
      group = vim.api.nvim_create_augroup("xavier", { clear = true }),
      pattern = "VeryLazy",
      callback = function()
        M.load("autocmds")
        M.load("keymaps")
      end,
    })
  else
    -- load them now so they affect the opened buffers
    M.load("autocmds")
    M.load("keymaps")
  end
end

function M.load(name)
  local Util = require("lazy.core.util")
  local function _load(mod)
    Util.try(function()
      require(mod)
    end, {
      msg = "Failed loading " .. mod,
      on_error = function(msg)
        local info = require("lazy.core.cache").find(mod)
        if info == nil or (type(info) == "table" and #info == 0) then
          return
        end
        Util.error(msg)
      end,
    })
  end
  -- always load lazyvim, then user file
  if M.defaults[name] then
    _load("xavier.config." .. name)
  end
  _load("xavier." .. name)
  if vim.bo.filetype == "lazy" then
    -- HACK: LazyVim may have overwritten options of the Lazy ui, so reset this here
    vim.cmd([[do VimResized]])
  end
end

M.did_init = false
function M.init()
  if not M.did_init then
    M.did_init = true
    -- delay notifications till vim.notify was replaced or after 500ms
    require("xavier.util").lazy_notify()

    -- load options here, before lazy init while sourcing plugin modules
    -- this is needed to make sure options will be correctly applied
    -- after installing missing plugins
    require("xavier.config").load("options")
  end
end


setmetatable(M, {
  __index = function(_, key)
    if options == nil then
      return vim.deepcopy(defaults)[key]
    end
    ---@cast options LazyVimConfig
    return options[key]
  end,
})


return M