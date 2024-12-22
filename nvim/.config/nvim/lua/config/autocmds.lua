-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local copilot_on = false
vim.api.nvim_create_user_command("CopilotToggle", function()
  if copilot_on then
    vim.cmd("Copilot disable")
    print("Copilot OFF")
  else
    vim.cmd("Copilot enable")
    print("Copilot ON")
  end
  copilot_on = not copilot_on
end, { nargs = 0 })
vim.keymap.set("", "<M-\\>", ":CopilotToggle<CR>", { noremap = true, silent = true })

-- Disable Ctrl-C in CodeCompanion buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "codecompanion", "Avante", "AvanteInput" }, -- handle both filetypes

  callback = function()
    -- Remove the Ctrl-C mapping in the buffer
    vim.keymap.set("n", "<C-c>", "<Nop>", { buffer = true })

    -- Optionally, you could show a message if someone presses Ctrl-C
    vim.keymap.set("n", "<C-c>", function()
      vim.notify("Use :q to close CodeCompanion", vim.log.levels.INFO)
    end, { buffer = true })
  end,
})
