-- Add Neovim and plugin specific terms to the spell checking dictionary
local M = {}

-- Plugin names and terms that should be recognized as correct
local spell_terms = {
  -- Plugin names
  "Mofiqul",
  "erikbackman",
  "brightburn",
  "folke",
  "tokyonight",
  "ellisonleao",
  "gruvbox",
  "echasnovski",
  "bufremove",
  "saiw",
  "surround",
  "cursorword",
  "indentscope",
  "splitjoin",
  "trailspace",
  
  -- Neovim specific terms
  "undercurl",
  "tabline",
  "statusline",
  "statuslines",
  "keymap",
  "keybinds",
  "Keymaps",
  "bufhidden",
  "winblend",
  "termopen",
  "startinsert",
  "autocmd",
  "augroup",
  "Bufremove",
  "Trailspace",
  "nner",
  "elete",
  "eplace",
  "priorirty",
}

function M.setup()
  -- Set spell file location
  local spell_path = vim.fn.stdpath('config') .. '/spell'
  vim.opt.spellfile = spell_path .. '/en.utf-8.add'
  
  -- Create spell directory if it doesn't exist
  if vim.fn.isdirectory(spell_path) == 0 then
    vim.fn.mkdir(spell_path, 'p')
  end
  
  -- Add terms to spell file if they don't exist
  local spellfile = io.open(vim.opt.spellfile:get(), 'r')
  local existing_terms = {}
  
  if spellfile then
    for line in spellfile:lines() do
      existing_terms[line] = true
    end
    spellfile:close()
  end
  
  local updated = false
  spellfile = io.open(vim.opt.spellfile:get(), 'a')
  
  if spellfile then
    for _, term in ipairs(spell_terms) do
      if not existing_terms[term] then
        spellfile:write(term .. '\n')
        updated = true
      end
    end
    spellfile:close()
    
    if updated then
      -- Reload spell checking
      vim.cmd('mkspell! ' .. vim.opt.spellfile:get())
    end
  end
  
  -- Enable spell checking
  vim.opt.spell = true
  vim.opt.spelllang = 'en'
  
  -- Don't mark these as spelling errors
  vim.opt.spelloptions:append('camel')
  vim.opt.spelloptions:append('noplainbuffer')
end

return M
