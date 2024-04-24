-- Setup nvim-cmp.
local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup {
  snippet = {
    expand = function(args)
      -- For `ultisnips` user.
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
    ["<CR>"] = cmp.mapping.confirm { select = false },
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
  },
  sources = {
    { name = "nvim_lsp" }, -- For nvim-lsp
    --{ name = "ultisnips" }, -- For ultisnips user.
    { name = "path" },     -- for path completion
    --{ name = "buffer", keyword_length = 2 }, -- for buffer word completion
    { name = "calc" },
  },
  completion = {
    keyword_length = 1,
    completeopt = "menu,noselect",
  },
  view = {
    entries = "custom",
  },
  formatting = {
    format = lspkind.cmp_format {
      mode = "symbol_text",
      menu = {
        nvim_lsp = "[LSP]",
        ultisnips = "[US]",
        nvim_lua = "[Lua]",
        path = "[Path]",
        buffer = "[Buffer]",
        omni = "[Omni]",
      },
    },
  },
  window = {
    documentation = cmp.config.window.bordered({
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
    }),
  },
  enabled = function()
    -- disable completion in comments
    local context = require 'cmp.config.context'
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      return not context.in_treesitter_capture("comment")
          and not context.in_syntax_group("Comment")
    end
  end
}

--[[ cmp.setup.filetype("tex", {
  sources = {
    { name = "omni" },
    { name = "ultisnips" }, -- For ultisnips user.
    { name = "buffer", keyword_length = 2 }, -- for buffer word completion
    { name = "path" }, -- for path completion
  },
}) ]]
