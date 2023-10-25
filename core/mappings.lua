local keymap = vim.keymap

-- Go to the beginning and end of current line in insert mode quickly
keymap.set("i", "<C-A>", "<HOME>")
keymap.set("i", "<C-E>", "<END>")

-- Edit and reload nvim config file quickly
keymap.set("n", "<leader>ov", "<cmd>e $MYVIMRC <bar> tcd %:h<cr>", {
  silent = true,
  desc = "open init.lua",
})

-- Move between windows quickly
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-l>", "<C-w>l")

-- Switch between two last buffers quickly
keymap.set("n", "<leader>b", "<C-^>", { desc = "Switch between two last buffers" })

-- Open journal entry
keymap.set("n", "<leader>oj", "<cmd>JournalOpen<cr>", { desc = "Open journal entry" })

-- Move between buffers
keymap.set("n", "<space>q", "<cmd>bn<cr>", { desc = "Previous buffer" })
keymap.set("n", "<space>p", "<cmd>bp<cr>", { desc = "Next buffer" })
