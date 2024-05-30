require('kanagawa').setup({
  compile = false,  -- enable compiling the colorscheme
  undercurl = true, -- enable undercurls
  commentStyle = { italic = false },
  functionStyle = {},
  keywordStyle = { italic = false, bold = true },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = false,   -- do not set background color
  dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
  terminalColors = true, -- define vim.g.terminal_color_{0,17}
  colors = {             -- add/modify theme and palette colors
    palette = {
      -- dragonBlack1 = "#000000",
      -- dragonBlack2 = "#000000",
      -- dragonBlack3 = "#000000",
      -- dragonBlack4 = "#111111",
      -- dragonBlack5 = "#222222",
      -- dragonBlack6 = "#444444",
    },
    theme = {
      wave = {},
      lotus = {},
      dragon = {
      },
      all = {
        ui = {
          bg_gutter = "none",
        }
      }
    },
  },
  overrides = function(colors)
    local theme = colors.theme
    return {
      NormalFloat = { bg = "none" },
      FloatBorder = { bg = "none" },
      FloatTitle = { bg = "none" },
      WinSeparator = { fg = theme.ui.bg_p2 },

      -- Save an hlgroup with dark background and dimmed foreground
      -- so that you can use it where your still want darker windows.
      -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
      NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

      -- Popular plugins that open floats will link to NormalFloat by default;
      -- set their background accordingly if you wish to keep them dark and borderless
      LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
      MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

      -- TelescopeTitle = { fg = theme.ui.special, bold = true },
      -- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
      -- TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
      -- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
      -- TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
      -- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
      -- TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

      GitGutterAddLineNr = { bg = theme.diff.add },
      GitGutterChangeLineNr = { bg = theme.diff.change },
      GitGutterDeleteLineNr = { bg = theme.diff.delete },

      DiagnosticVirtualTextError = { fg = theme.ui.nontext },
      DiagnosticVirtualTextWarn = { fg = theme.ui.nontext },

      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
      PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },
    }
  end,
  theme = "wave",
  background = {
    dark = "wave",
    light = "lotus"
  },
})

-- setup must be called before loading
-- vim.cmd("colorscheme kanagawa-dragon")
vim.cmd("colorscheme kanagawa")


vim.api.nvim_set_hl(0, "@lsp.type.comment.cpp", { link = "Comment" })
