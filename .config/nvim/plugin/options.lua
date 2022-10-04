vim.g.loaded_matchparen = 1

local opt = vim.opt
local api = vim.api

opt.wildignore = "__pycache__"
opt.wildignore = opt.wildignore + { "*.o", "*~", "*.pyc", "*pycache*" }

opt.pumblend = 17
opt.wildmode = "longest:full"
opt.wildoptions = "pum"

opt.showmode = false
opt.showcmd = true
opt.cmdheight = 0
opt.incsearch = true
opt.showmatch = true
opt.relativenumber = true
opt.number = true
opt.ignorecase = true
opt.smartcase = true
opt.hidden = true
opt.cursorline = true
opt.equalalways = false
opt.splitright = true
opt.splitbelow = true
opt.updatetime = 1000
opt.hlsearch = true
opt.scroll = 0 
opt.scrolloff = 0
opt.laststatus = 3

-- Tabs
opt.autoindent = true
opt.cindent = true
opt.wrap = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.breakindent = true
opt.showbreak = string.rep(" ", 3)
opt.linebreak = true

opt.foldmethod = "marker"
opt.foldlevel = 0
opt.modelines = 1

opt.belloff = "all"

opt.clipboard = "unnamedplus"

opt.inccommand = "split"
opt.swapfile = false
opt.shada = { "!", "'1000", "<50", "s10", "h" }

opt.mouse = "n"

opt.formatoptions = opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

-- set joinspaces
opt.joinspaces = false

-- set fillchars=eob:~
opt.fillchars = { 
  eob = "~",
  horiz = '━',
  horizup = '┻',
  horizdown = '┳',
  vert = '┃',
  vertleft  = '┫',
  vertright = '┣',
  verthoriz = '╋',
}

api.nvim_create_autocmd({ 'TermOpen' }, {
  pattern = '*',
-- command = 'setlocal nonu nornu | startinsert',
  callback = function(opts)
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.cmd('startinsert')
  end
})