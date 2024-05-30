local action_layout = require("telescope.actions.layout")

require('telescope').setup({
  defaults = vim.tbl_extend(
    "force",
    require('telescope.themes').get_dropdown(), -- or get_cursor, get_ivy
    {
      --- your own `default` options go here, e.g.:
      layout_config = {
        center = {
          height = 0.5,
          preview_cutoff = 40,
          prompt_position = "top",
          width = 0.6
        },
      },
      path_display = {
        truncate = 2
      },
      preview = {
        hide_on_startup = true -- hide previewer when picker starts
      },
      mappings = {
        n = {
          ["<M-p>"] = action_layout.toggle_preview
        },
        i = {
          ["<M-p>"] = action_layout.toggle_preview
        },
      }
    }
  )
})
