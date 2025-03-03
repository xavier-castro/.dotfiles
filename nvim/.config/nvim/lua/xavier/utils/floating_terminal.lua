vim.keymap.set({ "n", "t" }, "<A-F>", function()
  local current_dir = vim.fn.expand("%:p:h")
  if current_dir == "" or vim.fn.isdirectory(current_dir) == 0 then
    current_dir = vim.fn.getcwd()
  end
  local in_terminal = vim.bo.buftype == "terminal"
  if in_terminal then
    vim.cmd("hide")
  else
    Snacks.terminal.toggle("zsh", {
      cwd = current_dir,
      env = {
        TERM = "screen-256color",
      },
      win = {
        style = "terminal",
        relative = "editor",
        width = 0.85,
        height = 0.90,
        border = "rounded",
      },
    })
  end
end, { desc = "Toggle floating terminal" })
