return {
  {
    "folke/tokyonight.nvim",
    opts = function()
      return { style = "moon" }
    end,
    config = function()
      require("tokyonight").load()
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    config = function()
      require("kanagawa").load("dragon")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({})
    end,
  },
}
