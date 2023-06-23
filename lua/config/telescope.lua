local builtin = require('telescope.builtin')
local keymap = vim.keymap

keymap.set('n', '<leader>ff', builtin.git_files, {desc = "Browse project files"})
keymap.set('n', '<leader>fa', function() builtin.find_files({ cwd = "~"}) end, {desc = "Browse homedir"})
keymap.set('n', '<leader>fg', builtin.live_grep, {desc = "Live grep in cwd"})
keymap.set('n', '<leader>fb',  builtin.buffers, {desc = "Go to buffer"})
keymap.set('n', '<leader>fh', builtin.help_tags, {desc = "Filter help tags"})
keymap.set('n', '<leader>ft', builtin.treesitter, {desc = "Go to treesitter tag"})
