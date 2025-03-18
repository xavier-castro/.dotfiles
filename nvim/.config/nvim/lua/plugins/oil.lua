return {
  "stevearc/oil.nvim",
  -- enabled = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      default_file_explorer = true, -- start up nvim with oil instead of netrw
      columns = {},
      keymaps = {
        ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        ["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
        ["<c-c>"] = false,
        ["q"] = "actions.close",
      },
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          return name == "node_modules" or name == ".git"
        end,
      },
      float = {
        max_width = 235,
        max_height = 65,
      },
    })

    -- Oil
    vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open Oil" })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil", -- Adjust if Oil uses a specific file type identifier
      callback = function()
        vim.opt_local.cursorline = true
      end,
    })
  end,
}
