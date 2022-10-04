-- require 'impatient'


vim.g.mapleader = ","

vim.g.snippets = "luasnip"


require "plugins"



local colors = require "rc.colors"
colors.tokyonight()
