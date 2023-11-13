return {
  {
    'github/copilot.vim',
    lazy = false,
    config = function()
      vim.g.copilot_filetypes = {
        TelescopePrompt = false,
      }
      vim.g.copilot_no_tab_map = true
      vim.cmd [[
        imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")
        let g:copilot_no_tab_map = v:true
      ]]
    end,
    keys = {},
  },
}
