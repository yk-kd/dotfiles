

local M = {}

M.show_winbar = function(winbar)
    vim.opt.winbar = winbar
    vim.defer_fn(function() vim.opt.winbar = nil end, 5)
end

M.nmap = function(tbl)
  vim.keymap.set("n", tbl[1], tbl[2], tbl[3])
end

return M