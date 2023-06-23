local keymap = vim.keymap

keymap.set("n", "<leader>G", "<cmd>Git<cr>", { desc = "Git status" })

-- convert git to Git in command line mode
vim.fn['utils#Cabbrev']('git', 'Git')
