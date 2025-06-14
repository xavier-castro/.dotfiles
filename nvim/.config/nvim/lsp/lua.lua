-- https://www.reddit.com/r/neovim/comments/16lghio/luals_scanned_more_than_10000_file/
-- https://github.com/LuaLS/lua-language-server/issues/2975
return {
  cmd = { 'lua-language-server', '--force_accept_workspace' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
  },
  filetypes = { 'lua' }
}
