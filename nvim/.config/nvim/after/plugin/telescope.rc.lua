local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")
local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup {
  defaults = {
    path_display = { "smart" },
    file_ignore_patterns = {
      ".git/",
      "target/",
      "docs/",
      "vendor/*",
      "%.lock",
      "__pycache__/*",
      "%.sqlite3",
      "%.ipynb",
      "node_modules/*",
      -- "%.jpg",
      -- "%.jpeg",
      -- "%.png",
      "%.svg",
      "%.otf",
      "%.ttf",
      "%.webp",
      ".dart_tool/",
      ".github/",
      ".gradle/",
      ".idea/",
      ".settings/",
      ".vscode/",
      "__pycache__/",
      "build/",
      "env/",
      "gradle/",
      "node_modules/",
      "%.pdb",
      "%.dll",
      "%.class",
      "%.exe",
      "%.cache",
      "%.ico",
      "%.pdf",
      "%.dylib",
      "%.jar",
      "%.docx",
      "%.met",
      "smalljre_*/*",
      ".vale/",
      "%.burp",
      "%.mp4",
      "%.mkv",
      "%.rar",
      "%.zip",
      "%.7z",
      "%.tar",
      "%.bz2",
      "%.epub",
      "%.flac",
      "%.tar.gz",
    },
    initial_mode = "normal",
    mappings = {
      i = {
        ["<CR>"] = actions.select_default,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<c-d>"] = require("telescope.actions").delete_buffer,
      },
      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["q"] = actions.close
      },
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },
    file_browser = {
      theme = "dropdown",
      hijack_netrw = true,
      initial_mode = 'normal',
      mappings = {
        ["i"] = {
          ["<C-w>"] = function() vim.cmd('normal vbd') end,
        },
        ["n"] = {
          -- your custom normal mode mappings
          ['<C-w>'] = fb_actions.goto_cwd,
          ["q"] = actions.close,
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd('startinsert')
          end
        },
      },
    },
  },
  live_grep = {
    theme = "dropdown",
  },
  grep_string = {
    theme = "dropdown",
  },
  find_files = {
    theme = "dropdown",
    previewer = false,
  },
  buffers = {
    theme = "dropdown",
    previewer = false,
    initial_mode = "insert",
  },
  planets = {
    show_pluto = true,
    show_moon = true,
  },
  colorscheme = {
    enable_preview = true,
  },
  lsp_references = {
    theme = "dropdown",
    initial_mode = "normal",
  },
  lsp_definitions = {
    theme = "dropdown",
    initial_mode = "normal",
  },
  lsp_declarations = {
    theme = "dropdown",
    initial_mode = "normal",
  },
  lsp_implementations = {
    theme = "dropdown",
    initial_mode = "normal",
  },
}

telescope.load_extension('fzy_native')
telescope.load_extension("file_browser")
telescope.load_extension("harpoon")

vim.keymap.set('n', ';f',
  function()
    builtin.find_files({
      no_ignore = false,
      hidden = true,
      initial_mode = 'insert',
    })
  end)
vim.keymap.set('n', ';o', function()
  builtin.oldfiles(
    {
      previewer = false,
      initial_mode = 'insert',
    }
  )
end)
vim.keymap.set('n', '\\', function()
  telescope.extensions.file_browser.file_browser({
    -- path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = "normal",
    layout_config = { height = 40 }
  })
end)
vim.keymap.set('n', ';b', function()
  builtin.buffers({
    previewer = false,
    initial_mode = "insert",
  })
end)
vim.keymap.set('n', ';h', function()
  builtin.help_tags({
    initial_mode = "insert",
  })
end)
vim.keymap.set('n', ';;', function()
  builtin.marks()
end)
vim.keymap.set('n', ';d', function()
  builtin.diagnostics()
end)
vim.keymap.set("n", "sf", function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = "insert",
    layout_config = { height = 40 }
  })
end)
