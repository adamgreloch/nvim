local fn = vim.fn
local api = vim.api
local keymap = vim.keymap
local lsp = vim.lsp
local diagnostic = vim.diagnostic

local utils = require("utils")
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require("lspconfig")
local lsputil = require "lspconfig/util"

keymap.set("n", "<space>f", vim.lsp.buf.format, { desc = "format code" })

vim.lsp.set_log_level("off") -- disable logging for improved performance

keymap.set("n", "<space>a", vim.lsp.buf.code_action, { desc = "LSP code action" })

local custom_attach = function(client, bufnr)
  -- Mappings.
  local map = function(mode, l, r, opts)
    opts = opts or {}
    opts.silent = true
    opts.buffer = bufnr
    keymap.set(mode, l, r, opts)
  end

  map("n", "gD", vim.lsp.buf.declaration, { desc = "go to declaration" })
  map("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
  map("n", "gi", vim.lsp.buf.implementation, { desc = "go to implementation" })
  map("n", "<C-]>", vim.lsp.buf.definition)
  map("n", "K", vim.lsp.buf.hover)
  map("n", "<C-k>", vim.lsp.buf.signature_help)
  map("n", "<leader>R", vim.lsp.buf.rename, { desc = "variable rename" })
  map("n", "gr", vim.lsp.buf.references, { desc = "show references" })
  map("n", "[d", diagnostic.goto_prev, { desc = "previous diagnostic" })
  map("n", "]d", diagnostic.goto_next, { desc = "next diagnostic" })
  map("n", "<leader>q", diagnostic.setqflist, { desc = "put diagnostic to qf" })
  -- map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "add workspace folder" })
  -- map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "remove workspace folder" })

  api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local float_opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always", -- show source in diagnostic popup window
        prefix = " ",
      }

      if not vim.b.diagnostics_pos then
        vim.b.diagnostics_pos = { nil, nil }
      end

      local cursor_pos = api.nvim_win_get_cursor(0)
      if (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
          and #diagnostic.get() > 0
      then
        diagnostic.open_float(nil, float_opts)
      end

      vim.b.diagnostics_pos = cursor_pos
    end,
  })

  -- The blow command will highlight the current variable and its usages in the buffer.
  --
  -- Unless you're a deranged server like ocamllsp that abuses this highlighting,
  -- in which case it won't do anything.
  if client.server_capabilities.documentHighlightProvider and client.name ~= "ocamllsp" then
    vim.cmd([[
      hi! link LspReferenceRead Visual
      hi! link LspReferenceText Visual
      hi! link LspReferenceWrite Visual
    ]])

    local gid = api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    api.nvim_create_autocmd("CursorHold", {
      group = gid,
      buffer = bufnr,
      callback = function()
        lsp.buf.document_highlight()
      end
    })

    api.nvim_create_autocmd("CursorMoved", {
      group = gid,
      buffer = bufnr,
      callback = function()
        lsp.buf.clear_references()
      end
    })
  end

  if vim.g.logging_level == "debug" then
    local msg = string.format("Language server %s started!", client.name)
    vim.notify(msg, vim.log.levels.DEBUG, { title = "Nvim-config" })
  end
end

lspconfig.util.default_config.on_attach = custom_attach;

lspconfig.pylsp.setup {
  on_attach = custom_attach,
  flags = {
    debounce_text_changes = 200,
  },
  capabilities = capabilities,
}

if utils.executable("jdtls") then
  lspconfig.jdtls.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
  }
end

lspconfig.hls.setup {
  on_attach = custom_attach,
  capabilities = capabilities,
}

lspconfig.ocamllsp.setup {
  on_attach = custom_attach,
  capabilities = capabilities,
  root_dir = lsputil.root_pattern("Makefile", "*.opam", "esy.json", "package.json", ".git", "dune-project", "dune-workspace"),
}

if utils.executable("solidity-ls") then
  lspconfig.solidity.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
  }
end

if utils.executable("clangd") then
  lspconfig.clangd.setup {
    on_attach = custom_attach,
    capabilities = {
      textDocument = {
        semanticHighlightingCapabilities = {
          semanticHighlighting = true
        }
      }
    },
    filetypes = { "c", "cpp", "cc" },
  }
end

-- lspconfig.ltex.setup {
--   on_attach = function(client, bufnr)
--     custom_attach(client, bufnr)
--     -- require("ltex-utils").on_attach(bufnr)
--   end,
--   settings = {
--     ltex = {
--       language = "pl",
--       latex = {
--         commands = {
--           ["\\label{}"] = "dummy",
--           ["\\documentclass[]{}"] = "dummy",
--           ["\\cite{}"] = "dummy",
--           ["\\ref{}"] = "dummy",
--           ["\\cite[]{}"] = "dummy",
--           ["\\code{}"] = "dummy"
--         },
--         environments = {
--           ["figure"] = "ignore",
--         }
--       },
--     },
--   },
--   filetypes = {},
--   -- flags = { debounce_text_changes = 300 },
-- }

if utils.executable("pyright") then
  lspconfig.pyright.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
  }
end

-- set up vim-language-server
if utils.executable("vim-language-server") then
  lspconfig.vimls.setup {
    on_attach = custom_attach,
    flags = {
      debounce_text_changes = 500,
    },
    capabilities = capabilities,
  }
end

-- set up bash-language-server
if utils.executable("bash-language-server") then
  lspconfig.bashls.setup {
    on_attach = custom_attach,
    capabilities = capabilities,
  }
end

if utils.executable("lua-language-server") then
  -- settings for lua-language-server can be found on https://github.com/LuaLS/lua-language-server/wiki/Settings .
  lspconfig.lua_ls.setup {
    on_attach = custom_attach,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files,
          -- see also https://github.com/LuaLS/lua-language-server/wiki/Libraries#link-to-workspace .
          -- Lua-dev.nvim also has similar settings for lua ls, https://github.com/folke/neodev.nvim/blob/main/lua/neodev/luals.lua .
          library = {
            fn.stdpath("data") .. "/site/pack/packer/opt/emmylua-nvim",
            fn.stdpath("config"),
          },
          maxPreload = 2000,
          preloadFileSize = 50000,
        },
      },
    },
    capabilities = capabilities,
  }
end

-- global config for diagnostic
diagnostic.config {
  underline = true,
  virtual_text = true,
  signs = true,
  severity_sort = true,
  update_in_insert = true,
}

-- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
lsp.handlers['textDocument/hover'] = lsp.with(lsp.handlers.hover, { border = "single" })
lsp.handlers['textDocument/signatureHelp'] = lsp.with(lsp.handlers.signature_help, { border = "single" })
