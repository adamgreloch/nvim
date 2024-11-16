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
  ),
  pickers = {
    find_files = {
      mappings = {
        i = {
          ["<C-k>"] = function(prompt_bufnr)
            local current_picker =
                require("telescope.actions.state").get_current_picker(prompt_bufnr)
            -- cwd is only set if passed as telescope option
            local cwd = current_picker.cwd and tostring(current_picker.cwd)
                or vim.loop.cwd()
            local parent_dir = vim.fs.dirname(cwd)

            require("telescope.actions").close(prompt_bufnr)
            require("telescope.builtin").find_files {
              prompt_title = vim.fs.basename(parent_dir),
              cwd = parent_dir,
            }
          end,
        },
      },
    }
  }
})
