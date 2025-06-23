return {
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup {}

      -- Create toggle function with snacks-style configuration
      local function create_toggle(name, get_state, toggle_fn, opts)
        opts = opts or {}
        local icon = opts.icon or { enabled = " ", disabled = " " }
        local color = opts.color or { enabled = "green", disabled = "yellow" }

        return function()
          toggle_fn()
          local enabled = get_state()
          local status = enabled and "enabled" or "disabled"
          local icon_str = enabled and icon.enabled or icon.disabled
          local msg = string.format("%s %s %s", icon_str, name, status)

          vim.notify(msg, vim.log.levels.INFO, { title = "Toggle" })
        end
      end

      -- Supermaven toggle with snacks-style feedback
      local toggle_supermaven = create_toggle("Supermaven", function()
        return require("supermaven-nvim.api").is_running()
      end, function()
        require("supermaven-nvim.api").toggle()
      end, { icon = { enabled = "🤖", disabled = "🚫" } })

      -- Background toggle
      local toggle_background = create_toggle("Background", function()
        return vim.o.background == "dark"
      end, function()
        vim.o.background = vim.o.background == "dark" and "light" or "dark"
      end, { icon = { enabled = "🌙", disabled = "☀️" } })

      -- Transparency toggle
      local toggle_transparency = create_toggle("Transparency", function()
        return vim.g.transparency_enabled or false
      end, function()
        vim.g.transparency_enabled = not (vim.g.transparency_enabled or false)
        if vim.g.transparency_enabled then
          vim.cmd "hi Normal guibg=NONE ctermbg=NONE"
          vim.cmd "hi NonText guibg=NONE ctermbg=NONE"
          vim.cmd "hi SignColumn guibg=NONE ctermbg=NONE"
          vim.cmd "hi EndOfBuffer guibg=NONE ctermbg=NONE"
        else
          vim.cmd("colorscheme " .. vim.g.colors_name)
        end
      end, { icon = { enabled = "👻", disabled = "🎨" } })

      -- Relative line numbers toggle
      local toggle_relative_lines = create_toggle("Relative Lines", function()
        return vim.wo.relativenumber
      end, function()
        vim.wo.relativenumber = not vim.wo.relativenumber
      end, { icon = { enabled = "🔢", disabled = "📊" } })

      -- Line numbers toggle
      local toggle_line_numbers = create_toggle("Line Numbers", function()
        return vim.wo.number
      end, function()
        vim.wo.number = not vim.wo.number
      end, { icon = { enabled = "📋", disabled = "📄" } })

      -- LSP diagnostics toggle
      local toggle_diagnostics = create_toggle("Diagnostics", function()
        return vim.diagnostic.is_enabled()
      end, function()
        vim.diagnostic.enable(not vim.diagnostic.is_enabled())
      end, { icon = { enabled = "🩺", disabled = "🚫" } })

      -- Spelling toggle
      local toggle_spelling = create_toggle("Spelling", function()
        return vim.wo.spell
      end, function()
        vim.wo.spell = not vim.wo.spell
      end, { icon = { enabled = "📝", disabled = "✏️" } })

      -- Word wrap toggle
      local toggle_word_wrap = create_toggle("Word Wrap", function()
        return vim.wo.wrap
      end, function()
        vim.wo.wrap = not vim.wo.wrap
      end, { icon = { enabled = "🔄", disabled = "➡️" } })

      -- Conceallevel toggle
      local toggle_conceal = create_toggle("Conceal", function()
        return vim.wo.conceallevel > 0
      end, function()
        vim.wo.conceallevel = vim.wo.conceallevel > 0 and 0 or 2
      end, { icon = { enabled = "🔍", disabled = "👁️" } })

      -- Zen mode toggle (simple implementation)
      local toggle_zen = create_toggle("Zen Mode", function()
        return vim.g.zen_mode_enabled or false
      end, function()
        vim.g.zen_mode_enabled = not (vim.g.zen_mode_enabled or false)
        if vim.g.zen_mode_enabled then
          vim.cmd "set laststatus=0 showtabline=0 ruler"
          vim.cmd "set nonumber norelativenumber"
          vim.cmd "set signcolumn=no"
          vim.cmd "set foldcolumn=0"
        else
          vim.cmd "set laststatus=2 showtabline=2 ruler"
          vim.cmd "set number relativenumber"
          vim.cmd "set signcolumn=yes"
          vim.cmd "set foldcolumn=1"
        end
      end, { icon = { enabled = "🧘", disabled = "🖥️" } })

      -- Set up keybindings for all toggles
      vim.keymap.set("n", "<leader>tsm", toggle_supermaven, { desc = "Toggle Supermaven" })
      vim.keymap.set("n", "<leader>tb", toggle_background, { desc = "Toggle Background" })
      vim.keymap.set("n", "<leader>tt", toggle_transparency, { desc = "Toggle Transparency" })
      vim.keymap.set("n", "<leader>tl", toggle_relative_lines, { desc = "Toggle Relative Lines" })
      vim.keymap.set("n", "<leader>tn", toggle_line_numbers, { desc = "Toggle Line Numbers" })
      vim.keymap.set("n", "<leader>td", toggle_diagnostics, { desc = "Toggle Diagnostics" })
      vim.keymap.set("n", "<leader>ts", toggle_spelling, { desc = "Toggle Spelling" })
      vim.keymap.set("n", "<leader>tw", toggle_word_wrap, { desc = "Toggle Word Wrap" })
      vim.keymap.set("n", "<leader>tc", toggle_conceal, { desc = "Toggle Conceal" })
      vim.keymap.set("n", "<leader>tz", toggle_zen, { desc = "Toggle Zen Mode" })
    end,
  },
}
