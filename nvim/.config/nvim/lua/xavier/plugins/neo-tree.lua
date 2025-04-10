-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      sources = { 'filesystem' },

      enable_diagnostics = false,
      enable_git_status = false,

      filesystem = {
        hijack_netrw_behavior = 'disabled',
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
      },
      default_component_configs = {
        name = {
          trailing_slash = true,
          use_git_status_colors = false,
        },
        indent = {
          with_expanders = true,
        },
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
