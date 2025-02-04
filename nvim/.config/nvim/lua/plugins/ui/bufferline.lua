return {
  'alvarosevilla95/luatab.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('luatab').setup {
      title = function()
        return ''
      end,
      modified = function()
        return ''
      end,
      windowCount = function()
        return ''
      end,
      devicon = function()
        return ''
      end,
      separator = function()
        return ''
      end,
    }
  end,
}
