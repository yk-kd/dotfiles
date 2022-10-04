_ = vim.cmd [[packadd vim-jetpack]]

local has = function(x)
  return vim.fn.has(x) == 1
end

local executable = function(x)
  return vim.fn.executable(x) == 1
end

local is_wsl = (function()
  local output = vim.fn.systemlist "uname -r"
  return not not string.find(output[1] or "", "WSL")
end)()

return require("jetpack").startup(function(use)

    use { "tani/vim-jetpack", opt = 1 }
    use "lewis6991/impatient.nvim"
    -- use "camspiers/snap"

    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"

    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-rs.nvim"
    use "nvim-telescope/telescope-fzf-writer.nvim"
    use "nvim-telescope/telescope-packer.nvim"
    use "nvim-telescope/telescope-fzy-native.nvim"
    use "nvim-telescope/telescope-github.nvim"
    use "nvim-telescope/telescope-symbols.nvim"

    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use { "nvim-telescope/telescope-hop.nvim" }
    use { "nvim-telescope/telescope-file-browser.nvim" }
    use { "nvim-telescope/telescope-ui-select.nvim" }
    use { "nvim-telescope/telescope-smart-history.nvim" }
    
    use "stevearc/dressing.nvim"

    -- LSP Plugins:

    use "neovim/nvim-lspconfig"
    use "wbthomason/lsp-status.nvim"
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"

    use "j-hui/fidget.nvim"
    use "lvimuser/lsp-inlayhints.nvim"
    use {
      "ericpubu/lsp_codelens_extensions.nvim",
    }

    use "onsails/lspkind-nvim"
    use "jose-elias-alvarez/null-ls.nvim"
    -- use "glepnir/lspsaga.nvim"
    -- https://github.com/rmagatti/goto-preview

    --use "simrat39/rust-tools.nvim"
    use {
      "akinsho/flutter-tools.nvim",
      ft = { "flutter", "dart" },
    }

    use {
      "folke/lsp-trouble.nvim",
      cmd = "Trouble",
      run = function()
        require("trouble").setup {
          auto_preview = false,
          auto_fold = true,
        }
      end
    }

    use "SmiteshP/nvim-navic"

    use "rcarriga/nvim-notify"

    -- TODO: Investigate
    -- use 'jose-elias-alvarez/nvim-lsp-ts-utils'

    -- local_use("nvim-telescope", "telescope-async-sorter-test.nvim")

    use {
      "AckslD/nvim-neoclip.lua",
    }

    use "tami5/sql.nvim"
    use "nvim-telescope/telescope-frecency.nvim"
    use "nvim-telescope/telescope-cheat.nvim"

    use {
      "antoinemadec/FixCursorHold.nvim",
      run = function()
        vim.g.curshold_updatime = 1000
      end,
    }

    use "nanotee/luv-vimdocs"
    use "milisims/nvim-luaref"

    -- PRACTICE:
    use {
      "tpope/vim-projectionist", -- STREAM: Alternate file editting and some helpful stuff,
      enable = false,
    }

    use "haya14busa/vim-metarepeat" -- Never figured out how to use this, but looks like fun.


    -- Make comments appear IN YO FACE
    use {
      "tjdevries/vim-inyoface",
    }

    -- Quickfix enhancements. See :help vim-qf
    use "romainl/vim-qf"

    -- TODO: Eventually statusline should consume this.
    use "kyazdani42/nvim-web-devicons"
    if not is_wsl then
      use "yamatsum/nvim-web-nonicons"
    end
    use "nvim-lualine/lualine.nvim"

    use {"lukas-reineke/indent-blankline.nvim", enable=false}

    use "L3MON4D3/LuaSnip"
    use "honza/vim-snippets"

    -- Languages
    use { "neovimhaskell/haskell-vim", ft = "haskell" }
    use { "elzr/vim-json", ft = "json" }
    use { "udalov/kotlin-vim", ft = "kotlin" }
    use { "ziglang/zig.vim", ft = "zig" }

    -- Completion

    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp"
    
    use "hrsh7th/cmp-nvim-lsp-document-symbol"
    use "saadparwaiz1/cmp_luasnip"
    use "tamago324/cmp-zsh"

    -- Comparators
    use "lukas-reineke/cmp-under-comparator"

    if executable "deno" and false then
      use "vim-denops/denops.vim"
      use "lambdalisue/guise.vim"
      use "Shougo/ddu.vim"
      use "Shougo/ddu-ui-ff"
      use "Shougo/ddu-ui-filer"
      use "Shougo/ddu-source-file"
      use "Shougo/ddu-source-file_rec"
      use "matsui54/ddu-source-file_external"
      use "Shougo/ddu-source-line"
      use "Shougo/ddu-source-register"
      use "Shougo/ddu-source-rg"
      use "Shougo/ddu-source-buffer"
      use "Shougo/ddu-filter-matcher_substring"
      use "Shougo/ddu-commands.vim"
      use "Shougo/ddu-kind-file"
      use "Shougo/ddu-column-filename"
      use "ryota2357/ddu-column-icon_filename"
      use "lambdalisue/gin.vim"
    end

    -- use "Shougo/ddc.vim"
    -- use "Shougo/ddc-nvim-lsp"


    -- Cool tags based viewer
    --   :Vista  <-- Opens up a really cool sidebar with info about file.
    use { "liuchengxu/vista.vim", on = "Vista" }

    -- Find and replace
    use "windwp/nvim-spectre"

    -- Debug adapter protocol
    use "mfussenegger/nvim-dap"
    use "rcarriga/nvim-dap-ui"
    use "theHamsta/nvim-dap-virtual-text"
    use "nvim-telescope/telescope-dap.nvim"
    use "mfussenegger/nvim-dap-python"


    use "mfussenegger/nvim-dap-python"
    use "jbyuki/one-small-step-for-vimkind"

    -- use {
    --   "rcarriga/vim-ultest",

    --   enable = false,
    --   requires = { "vim-test/vim-test" },
    --   run = ":UpdateRemotePlugins",
    --   config = function()
    --     vim.cmd [[nmap ]t <Plug>(ultest-next-fail)]]
    --     vim.cmd [[nmap [t <Plug>(ultest-prev-fail)]]
    --   end,
    -- }

    -- TREE SITTER:
    use "nvim-treesitter/nvim-treesitter"
    use "nvim-treesitter/playground"
    use "vigoux/architext.nvim"

    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "JoosepAlviste/nvim-ts-context-commentstring"
    use {
      "mfussenegger/nvim-ts-hint-textobject",
    }

    -- Grammars
    -- use { "m-novikov/tree-sitter-sql" }
    -- use { "DerekStride/tree-sitter-sql" }
    -- local_use "tree-sitter-sql"

    --
    -- NAVIGATION:
    -- STREAM: Show off edit_alternate.vim

    use "google/vim-searchindex"

    use "pechorin/any-jump.vim"

    --
    -- TEXT MANIUPLATION
    use "godlygeek/tabular" -- Quickly align text by pattern
    use "tpope/vim-repeat" -- Repeat actions better
    use "tpope/vim-abolish" -- Cool things with words!
    use "tpope/vim-characterize"
    use { "tpope/vim-dispatch", on = { "Dispatch", "Make" } }

    use "numToStr/Comment.nvim"

    use {
      "AndrewRadev/splitjoin.vim",
    }

    -- TODO: Check out macvhakann/vim-sandwich at some point
    use "tpope/vim-surround" -- Surround text objects easily

    --
    -- GIT:
    use "TimUntersberger/neogit"

    -- Github integration
    if vim.fn.executable "gh" == 1 then
      use "pwntester/octo.nvim"
    end
    use "ruifm/gitlinker.nvim"

    -- Sweet message committer
    use "rhysd/committia.vim"
    use "sindrets/diffview.nvim"

    -- Floating windows are awesome :)
    use {
      "rhysd/git-messenger.vim",
    }

    -- Async signs!
    use "lewis6991/gitsigns.nvim"

    -- Git worktree utility
    use {
      "ThePrimeagen/git-worktree.nvim",
    }

    use "ThePrimeagen/harpoon"

    -- use 'untitled-ai/jupyter_ascending.vim'

    use "Vhyrro/neorg"

    use "akinsho/bufferline.nvim"
    use "akinsho/toggleterm.nvim"

    use "folke/tokyonight.nvim"
    use "rebelot/kanagawa.nvim"
    -- use "RSyiets/vim-git-foresta"
    -- pretty sure I'm done w/ these
    -- local_use 'vlog.nvim'

  end)