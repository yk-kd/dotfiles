local vim = vim
local g = vim.g

local M = {}

vim.opt.termguicolors = true
vim.opt.background = "dark"

function M.tokyonight()
  g.tokyonight_sidebars = {} -- { "qf", "vista", "terminal", "packer", "NvimTree" , 'Trouble', 'tagbar' }
  g.tokyonight_colors = { border = "dark3" }
  vim.cmd("colorscheme tokyonight-night") -- this has to be specified last
end

function M.kanagawa()
  require("kanagawa").setup({
      dimInactive = false,
      globalStatus = true,
      overrides = {
        LspInlayHints
      },
      theme = "default",
  })
  vim.cmd("colorscheme kanagawa")
end
local kanagawa = require("kanagawa.colors").setup()
local colors = {}
setmetatable(colors, {__index = function () return "tokyonight" end})
colors.tokyonight = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}
colors.kanagawa = {
  bg = kanagawa.sumiInk1,
  fg = kanagawa.sumiInk0,
  yellow = kanagawa.boatYellow2,
  cyan = kanagawa.waveAqua1,
  darkblue = kanagawa.crystalBlue,
  green = kanagawa.autumnGreen,
  orange = kanagawa.surimiOrange,
  violet = kanagawa.oniViolet,
  magenta = kanagawa.springViolet1,
  blue = kanagawa.springBlue,
  red = kanagawa.autumnRed,
}
function M.colors()
  return colors[g.colors_name]
end

return M
