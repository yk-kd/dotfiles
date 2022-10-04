vim.g.mapleader = " "
vim.g.localmapleader = ","

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)
vim.api.nvim_create_user_command("GenerateImportMap", function()
    local text = vim.api.nvim_buf_get_lines(0, 0, -1, true)
    local imports = {}
    for _, line in ipairs(text) do
        if string.match(line, "^import") then
            -- import { hoge } from "hoge" => import { hoge } from "npm:hoge"
            -- import { hoge } from 'hoge' => import { hoge } from 'npm:hoge'
            local module = string.match(line, '\'([^"]+)\'')
            imports[module] = "npm:" .. module
        end
    end
    -- set replaced text to current buffer
    local file = "./deno.json"
    local fd = io.open(file, "w+")
    if not fd then
      error(("Could not open file %s for writing"):format(file))
    end
    fd:write(vim.json.encode({imports = imports}))
    fd:close()
end, {})

require("lazy").setup("plugins", {
  defaults = { lazy = true },
  install = { colorscheme = { "kanagawa", "tokyonight", "catppuccin" } },
  checker = { enabled = true },
  diff = {
    cmd = "terminal_git",
  },
  performance = {
    cache = {
      enabled = true,
      -- disable_events = {},
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "nvim-treesitter-textobjects",
      },
    },
  },
  ui = {
    custom_keys = {
      ["<localleader>d"] = function(plugin)
        dd(plugin)
      end,
    },
  },
  debug = true,
})
