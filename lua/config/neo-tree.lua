require("neo-tree").setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = true,
      hide_gitignored = true
    },
    follow_current_file = {
      enabled = true,
      leave_dirs_open = false,
    }
  },
  default_component_configs = {
    container = {
      enable_character_fade = true
    },
    indent = {
      indent_size = 1,
      padding = 0, -- extra padding on left hand side
      -- indent guides
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      -- expander config, needed for nesting files
      with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = "-",
      expander_expanded = "+",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = "+",
      folder_open = "-",
      folder_empty = "",
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = "*",
      highlight = "NeoTreeFileIcon"
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        -- Change type
        added     = "a", -- or "✚", but this is redundant info if you use git_status_colors on the name
        modified  = "m", -- or "", but this is redundant info if you use git_status_colors on the name
        deleted   = "d", -- this can only be used in the git_status source
        renamed   = "r", -- this can only be used in the git_status source
        -- Status type
        untracked = "?",
        ignored   = "i",
        unstaged  = "u",
        staged    = "s",
        conflict  = "c",
      }
    },
  }
})
