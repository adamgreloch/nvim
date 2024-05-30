local builtin = require('telescope.builtin')
local keymap = vim.keymap

keymap.set('n', '<leader>ff', builtin.git_files, { desc = "Browse project files" })
keymap.set('n', '<leader>fa', function() builtin.find_files({ cwd = "~" }) end, { desc = "Browse homedir" })
keymap.set('n', '<leader>fg', function() builtin.live_grep({ cwd = project_wd }) end, { desc = "Live grep in cwd" })
keymap.set('n', '<leader>fG', builtin.git_commits, { desc = "Git commits" })
keymap.set('n', '<leader>B', builtin.buffers, { desc = "Go to buffer" })
keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Filter help tags" })
keymap.set('n', '<leader>F', builtin.lsp_document_symbols, { desc = "List LSP document symbols" })

local telescope = require('telescope')
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
  extensions = {
    frecency = {
      db_safe_mode = false,
    }
  }
})

vim.keymap.set("n", "<leader><leader>", function()
  telescope.extensions.frecency.frecency {
  }
end)
