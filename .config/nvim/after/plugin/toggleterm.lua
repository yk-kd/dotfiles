require'toggleterm'.setup {
  shade_terminals = false,
  float_opts = {
    border = 'curved'
  },
  winbar = { enabled = true },
}

local nmap = require("rc.keymap").nmap

local Terminal  = require('toggleterm.terminal').Terminal
local gitgraph = Terminal:new { cmd = "git graph", hidden = true, direction = "float" }
function _gitgraph_toggle()
  gitgraph:toggle()
end

nmap { "<leader>gg", _gitgraph_toggle }