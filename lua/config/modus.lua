require("modus-themes").setup({
  -- Theme comes in two styles `modus_operandi` and `modus_vivendi`
  -- `auto` will automatically set style based on background set with vim.o.background
  style = "auto",
  variant = "default",             -- Theme comes in four variants `default`, `tinted`, `deuteranopia`, and `tritanopia`
  transparent = false,             -- Transparent background (as supported by the terminal)
  dim_inactive = false,            -- "non-current" windows are dimmed
  hide_inactive_statusline = false, -- Hide statuslines on inactive windows. Works with the standard **StatusLine**, **LuaLine** and **mini.statusline**
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = false },
    keywords = { italic = false },
    functions = {},
    variables = {},
  },

  on_colors = function(colors)
    colors.error = colors.red_faint   -- Change error color to the "faint" variant
  end,

  on_highlights = function(highlight, color)
    -- highlight.Boolean = { fg = color.green }   -- Change Boolean highlight to use the green color
    highlight.LineNr = { fg = color.fg_dim, bg = color.bg_alt }
    -- highlight.LineNrAbove = { fg = color.fg_dim, bg = color.bg_alt }
    -- highlight.LineNrBelow = { fg = color.fg_dim, bg = color.bg_alt }
    highlight.SignColumn = { bg = color.bg_alt }
    highlight.StatusLine = { bg = color.bg_alt }
    highlight.StatusLineNC = { bg = color.bg_alt }
    highlight.NeoTreeNormal = { bg = color.bg }
    highlight.NeoTreeNormalNC = { bg = color.bg }
    -- highlight.NormalFloat = { bg = "none" }
    -- highlight.FloatBorder = { bg = "none" }
    -- highlight.FloatTitle = { bg = "none" }
    highlight.GitSignsAdd = { fg = color.fg_added, bg = color.bg_alt }
    highlight.GitSignsDelete = { fg = color.fg_removed, bg = color.bg_alt }
    highlight.GitSignsChange = { fg = color.fg_changed, bg = color.bg_alt }
  end,
})

vim.cmd("colorscheme modus")

vim.api.nvim_set_hl(0, "@lsp.type.comment.cpp", { link = "Comment" })
