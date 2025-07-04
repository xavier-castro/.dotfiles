-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

-- https://github.com/AstroNvim/astrocommunity/blob/main/README.md

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.programming-language-support.web-tools-nvim" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.search.grug-far-nvim" },
  { import = "astrocommunity.lsp.ts-error-translator-nvim" },
  { import = "astrocommunity.quickfix.quicker-nvim" },
  { import = "astrocommunity.color.transparent-nvim" },
  -- import/override with your plugins folder
}
