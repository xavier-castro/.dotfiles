-- lazy.nvim
return {
  "chrisgrieser/nvim-rip-substitute",
  cmd = "RipSubstitute",
  opts = {},
  keys = {
    {
      "<localleader>sr",
      function()
        require("rip-substitute").sub()
      end,
      mode = { "n", "x" },
      desc = " rip substitute",
    },
  },
}