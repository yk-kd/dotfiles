local utils = require 'rc.utils'
local imap, nmap = require('rc.keymap').imap, require('rc.keymap').nmap

local has_lsp, lspconfig = pcall(require, "lspconfig")
if not has_lsp then
  return
end

require("fidget").setup()
local navic = require("nvim-navic")
navic.setup()

local function show_location()
  vim.opt.winbar = "%=" .. navic.get_location()
  vim.defer_fn(function() vim.opt.winbar = nil end, 5000)
end

local inlayhints = require("lsp-inlayhints")
inlayhints.setup()
local telescope_mapper = require "rc.telescope.mappings"

local buf_nnoremap = function(opts)
  opts.buffer = 0
  nmap(opts)
end

local buf_inoremap = function(opts)
  opts.buffer = 0
  imap(opts)
end
local filetype_attach = setmetatable({
  go = function(client)
    vim.cmd [[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
      augroup END
    ]]
  end,

  rust = function()
    telescope_mapper("<space>wf", "lsp_workspace_symbols", {
      ignore_filename = true,
      query = "#",
    }, true)

    --vim.cmd [[
    --  autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions').inlay_hints{ aligned = true, prefix = " » ", highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"}}
    --]]

    vim.cmd [[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
      augroup END
    ]]
  end,
}, {
  __index = function()
    return function() end
  end,
})
local custom_attach = function(client, bufnr)
  navic.attach(client, bufnr)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")


  buf_inoremap { "<c-s>", vim.lsp.buf.signature_help }

  buf_nnoremap { "<space>cr", vim.lsp.buf.rename }
  telescope_mapper("<space>ca", "lsp_code_actions", nil, true)

  buf_nnoremap { "gd", vim.lsp.buf.definition }
  buf_nnoremap { "gD", vim.lsp.buf.declaration }
  buf_nnoremap { "gT", vim.lsp.buf.type_definition }

  buf_nnoremap { "ti", inlayhints.toggle }
  buf_nnoremap { "<space>sl", show_location }

  buf_nnoremap { "<space>gI", vim.lsp.buf.implementation }
  buf_nnoremap { "<space>lr", "<cmd>lua R('rc.lsp.codelens').run()<CR>" }
  buf_nnoremap { "<space>rr", "LspRestart" }

  telescope_mapper("gr", "lsp_references", nil, true)
  telescope_mapper("gI", "lsp_implementations", nil, true)
  telescope_mapper("<space>wd", "lsp_document_symbols", { ignore_filename = true }, true)
  telescope_mapper("<space>ww", "lsp_dynamic_workspace_symbols", { ignore_filename = true }, true)

  if filetype ~= "lua" then
    buf_nnoremap { "K", vim.lsp.buf.hover }
  end

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"


  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

  if client.resolved_capabilities.code_lens then
    vim.cmd [[
      augroup lsp_document_codelens
        au! * <buffer>
        autocmd BufEnter ++once         <buffer> lua require"vim.lsp.codelens".refresh()
        autocmd BufWritePost,CursorHold <buffer> lua require"vim.lsp.codelens".refresh()
      augroup END
    ]]
  end

  -- Attach any filetype specific options to the client
  filetype_attach[filetype](client)
end
require('mason').setup()
require('mason-lspconfig').setup_handlers{ function(server)
  local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
  updated_capabilities.textDocument.completion.completionItem.snippetSupport = true
  updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)
  local opt = {
    capabilities = update_capabilities,
    on_attach = custom_attach,
  }
  if server == "denols" then
    opt.init_options = {
      lint = true,
      unstable = true,
      suggest = {
        imports = {
          hosts = {
            ["https://deno.land"] = true,
            ["https://cdn.nest.land"] = true,
            ["https://crux.land"] = true
          }
        }
      }
    }
  elseif server == "tsserver" then
    opt.root_dir = lspconfig.util.root_pattern("package.json")
  end
  lspconfig[server].setup(opt)
end
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    navic.attach(client, bufnr)
    inlayhints.on_attach(bufnr, client)
  end,
})
