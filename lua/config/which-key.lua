require("which-key").setup {
  plugins = {
    marks = true,      -- shows a list of your marks on ' and `
    registers = true,  -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,  -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 9, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      motions = true,      -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true,      -- default bindings on <c-w>
      nav = true,          -- misc bindings to work with windows
      z = true,            -- bindings for folds, spelling and others prefixed with z
      g = true,            -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  icons = {
    breadcrumb = "-", -- symbol used in the command line area that shows your active key combo
    separator = ">",  -- symbol used between a key and it's label
    group = "+",      -- symbol prepended to a group
  },
  layout = {
    height = { min = 1, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 1,                    -- spacing between columns
    align = "center",               -- align columns left, center or right
  },
  show_help = true,                 -- show help message on the command line when the popup is visible
  triggers = {
    { "<auto>", mode = "nxso" },
  },
}
