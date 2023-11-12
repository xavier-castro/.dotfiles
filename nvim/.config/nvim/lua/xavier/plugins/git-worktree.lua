return {
  -- git-worktree.nvim
  {
    -- https://github.com/ThePrimeagen/git-worktree.nvim/pull/106
    'brandoncc/git-worktree.nvim',
    branch = 'catch-and-handle-telescope-related-error',
    lazy = true,
    keys = {
      {
        '<leader>pf',
        function()
          local Job = require 'plenary.job'

          local current_file = vim.fn.resolve(vim.fn.expand '%')
          local file_directory = vim.fn.fnamemodify(current_file, ':p:h')
          local branch_name = utils.branch_name(nil, file_directory)

          Job:new({
            command = 'zellij',
            args = {
              'run',
              '-f',
              '--',
              'fish',
            },
            cwd = file_directory,
            on_exit = function()
              Job:new({
                command = 'zellij',
                args = {
                  'action',
                  'rename-pane',
                  branch_name,
                },
              }):start()
            end,
          }):start()
        end,
        desc = 'Open floating pane inside worktree',
      },
      {
        '<leader>pw',
        function()
          vim.ui.input({ prompt = 'Git branch: ' }, function(branch)
            local data = {}
            data.git_branch = branch

            vim.ui.input({ prompt = 'Unique path: ' }, function(path)
              data.unique_path = path

              require('git-worktree').create_worktree(data.unique_path, data.git_branch)
            end)
          end)
        end,
        desc = 'Create new worktree',
      },
    },
    config = true,
  },
}
