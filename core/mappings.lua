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

keymap.set("n", "<Leader>r", ":%s/\\<<C-r><C-w>\\>/")

-- Switch between two last buffers quickly
keymap.set("n", "<leader>b", "<C-^>", { desc = "Switch between two last buffers" })

-- Open journal entry
keymap.set("n", "<leader>oj", "<cmd>JournalOpen<cr>", { desc = "Open journal entry" })

-- Quit
keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit" })

-- Move between buffers
-- keymap.set("n", "<space>q", "<cmd>bn<cr>", { desc = "Previous buffer" })
-- keymap.set("n", "<space>p", "<cmd>bp<cr>", { desc = "Next buffer" })

-- Set bg to light
keymap.set("n", "<leader>L", "<cmd>set bg=light<cr>", { desc = "Set light background" })

vim.api.nvim_create_user_command('Ngrep', 'lvimgrep "<args>" **/* | lopen', { nargs = 1 })
keymap.set("n", "<leader><Tab>", [[":Ngrep " . expand("<cword>") . "<cr>"]], { desc = "grep", expr = true })
keymap.set("n", "<C-n>", ":lnext<cr>", { desc = "next in loclist" })
keymap.set("n", "<C-p>", ":lprev<cr>", { desc = "prev in loclist" })

vim.api.nvim_create_user_command('Retab4to2', 'set ts=4 sts=4 noet | retab! | set ts=2 sts=2 et | retab!', {})

-- Git
keymap.set("n", "<space>p", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview git hunk" })
keymap.set("n", "<space>r", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset git hunk" })
keymap.set("n", "<space>d", "<cmd>Gdiffsplit<cr>", { desc = "Git diff this" })
keymap.set("n", "<space>b", "<cmd>Git blame<cr>", { desc = "Git blame" })
