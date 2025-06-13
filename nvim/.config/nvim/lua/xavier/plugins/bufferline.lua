return -- buffer line
{
  'akinsho/bufferline.nvim',
  event = 'BufEnter',
  keys = {
    { '<tab>', '<cmd>bufferlinecyclenext<cr>', desc = 'next tab' },
    { '<s-tab>', '<cmd>bufferlinecycleprev<cr>', desc = 'prev tab' },
  },
  opts = {
    options = {
      mode = 'tabs',
      -- separator_style = "slant",
      show_buffer_close_icons = false,
      show_close_icon = false,
    },
  },
}
