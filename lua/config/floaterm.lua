local keymap = vim.keymap

keymap.set('n', "<leader>nt", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 zsh <CR> ")
keymap.set('n', "<leader>x", ":FloatermToggle myfloat<CR>")
keymap.set('t', "<leader>x", "<C-\\><C-n>:q<CR>")
