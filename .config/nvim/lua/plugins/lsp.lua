return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
      "hrsh7th/cmp-nvim-lsp",
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "dnlhc/glance.nvim"
    },
    config = function(_, _)
      require("neodev").setup({})
      local lspconfig = require("lspconfig")

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf ---@type number
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
          vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = 0 })
          vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
          vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { buffer = 0 })

          vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
          vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
          vim.keymap.set("n", "<space>wd", require("telescope.builtin").lsp_document_symbols, { buffer = 0 })
          vim.keymap.set("n", "<space>th", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { buffer = 0 }) end)

          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

          local filetype = vim.bo[bufnr].filetype
          --if filetype == "python"
          --vim.lsp.commands["basedpyright.createtypestub"] = function (command, ctx)
          --  client.request('workspace/executeCommand', command, nil, 0)
          --end

        end,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities(lspconfig.util.default_config)
      lspconfig.util.default_config = {
        capabilities = capabilities,
      }
      lspconfig.sourcekit.setup {
        cmd = {'/usr/bin/sourcekit-lsp'},
        filetypes = { "swift", "objective-c", "objective-cpp" }
      }
      lspconfig.metals.setup {
        cmd = { vim.fn.expand('~/.local/share/coursier/bin/metals') },
        filetypes = { "scala" }
      }
      require("mason")
      require("mason-lspconfig").setup_handlers({
        function(server)
          lspconfig[server].setup({ autostart = true })
        end,
        ["gopls"] = function()
          lspconfig.gopls.setup({
            autostart = true,
            settings = {
              gopls = {
                hints = {
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  constantValues = true,
                  functionTypeParameters = true,
                  parameterNames = true,
                  rangeVariableTypes = true,
                },
              },
            },
          })
        end,
        ["basedpyright"] = function ()
          lspconfig.basedpyright.setup({
            autostart = true,
            cmd = { 'basedpyright-langserver', '--stdio', '--verbose' },
            settings = {
              basedpyright = {
                disableOrganizeImports = true,
                analysis = {
                  autoSearchPaths = true,
                  typeCheckingMode = "strict",
                  diagnosticMode = "openFilesOnly",
                  diagnosticSeverityOverrides = {
                    reportUndefinedVariable = false,
                    reportUnusedImport = false,
                  },
                }
              },
            },
          })
        end,
        ["denols"] = function()
          --local node_root_dir = lspconfig.util.root_pattern("package.json")
          --local is_deno = not (node_root_dir(vim.api.nvim_buf_get_name(0)))
          lspconfig.denols.setup({
            root_dir = lspconfig.util.root_pattern(""),
            --autostart = is_deno,
            autostart = true,
            settings = {
              lint = true,
              unstable = true,
              node_modules_dir = true,
              suggest = {
                imports = {
                  hosts = {
                    ["https://deno.land"] = true,
                    ["https://cdn.nest.land"] = true,
                    ["https://crux.land"] = true,
                  },
                },
              },
            },
          })
        end,
        ["typescript-language-server"] = function()
          lspconfig.tsserver.setup({
            autostart = false,
          })
        end,
        ["omnisharp"] = function()
          lspconfig.omnisharp.setup({
            autostart = false,
            cmd = { "OmniSharp" },
            enable_roslyn_analyzers = true,
            organize_imports_on_format = true,
            analyze_open_documents_only = true,
          })
        end,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(plugin, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
}
