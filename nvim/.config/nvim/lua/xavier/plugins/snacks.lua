-- Create a Pick function that wraps mini.pick to be compatible with LazyVim.pick
local function create_pick_fn(command, opts)
  opts = opts or {}
  return function()
    local mini_pick = require 'mini.pick'
    local mini_extra = require 'mini.extra'

    if command == 'files' then
      if opts.root == false then
        mini_pick.builtin.files({}, { source = { cwd = vim.fn.getcwd() } })
      else
        mini_pick.builtin.files()
      end
    elseif command == 'grep' or command == 'live_grep' then
      if opts.root == false then
        mini_pick.builtin.grep_live({}, { source = { cwd = vim.fn.getcwd() } })
      else
        mini_pick.builtin.grep_live()
      end
    elseif command == 'grep_word' then
      local word = vim.fn.expand '<cword>'
      if opts.root == false then
        mini_pick.builtin.grep_live({ default_text = word }, { source = { cwd = vim.fn.getcwd() } })
      else
        mini_pick.builtin.grep_live { default_text = word }
      end
    elseif command == 'oldfiles' then
      mini_extra.pickers.oldfiles()
    end
  end
end

local Pick = setmetatable({
  config_files = function()
    return function()
      require('mini.pick').builtin.files({}, { source = { cwd = vim.fn.stdpath 'config' } })
    end
  end,
}, {
  __call = function(_, command, opts)
    return create_pick_fn(command, opts)
  end,
})

return {
  'folke/snacks.nvim',
  opts = {
    picker = {
      win = {
        input = {
          keys = {
            ['<a-c>'] = {
              'toggle_cwd',
              mode = { 'n', 'i' },
            },
          },
        },
      },
      actions = {
        ---@param p snacks.Picker
        toggle_cwd = function(p)
          local root = vim.fs.normalize((vim.uv or vim.loop).cwd() or '.')
          local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or '.')
          local current = p:cwd()
          p:set_cwd(current == root and cwd or root)
          p:find()
        end,
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>/", Pick("grep"), desc = "Grep (Root Dir)" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader><space>", Pick("files"), desc = "Find Files (Root Dir)" },
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
    -- find
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fB", function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, desc = "Buffers (all)" },
    { "<leader>fc", Pick.config_files(), desc = "Find Config File" },
    { "<leader>ff", Pick("files"), desc = "Find Files (Root Dir)" },
    { "<leader>fF", Pick("files", { root = false }), desc = "Find Files (cwd)" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Files (git-files)" },
    { "<leader>fr", Pick("oldfiles"), desc = "Recent" },
    { "<leader>fR", function() Snacks.picker.recent({ filter = { cwd = true }}) end, desc = "Recent (cwd)" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    -- git
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (hunks)" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
    -- Grep
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<leader>sg", Pick("live_grep"), desc = "Grep (Root Dir)" },
    { "<leader>sG", Pick("live_grep", { root = false }), desc = "Grep (cwd)" },
    { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
    { "<leader>sw", Pick("grep_word"), desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },
    { "<leader>sW", Pick("grep_word", { root = false }), desc = "Visual selection or word (cwd)", mode = { "n", "x" } },
    -- search
    { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
    { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
    { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
    { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undotree" },
    -- ui
    { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
  },
}
