local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

-- Prefer creating groups and assigning autocmds to groups, because it makes it easier to clear them
augroup("mygroup", { clear = true })

autocmd({ "FileType" }, {
  pattern = { "markdown", "json" },
  callback = function()
    vim.wo.conceallevel = 0
  end,
  group = "mygroup",
})

local function search_by_file_type(command_name, file_pattern, prompt_title)
  usercmd(command_name, function()
    require('telescope.builtin').find_files({
      search_file = file_pattern,
      prompt_title = prompt_title,
    })
  end, {})
end

local function search_by_directory(command_name, dir, prompt_title)
  usercmd(command_name, function()
    require('telescope.builtin').find_files({
      cwd = dir,
      prompt_title = prompt_title,
    })
  end, {})
end

local function grep_notes(command_name, dir, prompt_title)
  usercmd(command_name, function()
    require('telescope.builtin').live_grep({
      cwd = dir,
      type_filter = "md",
      prompt_title = prompt_title,
    })
  end, {})
end

-- Note lookup
search_by_directory("SearchNotes", "~/xcvault/notes", "Search markdown notes")
grep_notes("GrepNotes", "~/xcvault/notes/", "Grep markdown files")

-- Note lookup
vim.keymap.set("n", "<leader>fn", ":SearchNotes<CR>", { desc = "Find Notes", noremap = true, silent = true })
vim.keymap.set("n", "<leader>fN", ":GrepNotes<CR>", { desc = "Grep Notes", noremap = true, silent = true })
