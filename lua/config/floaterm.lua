local keymap = vim.keymap

keymap.set('n', "<leader>nt", ":FloatermNew --name=myfloat --height=0.8 --width=0.9 --autoclose=2 zsh <CR> ")
keymap.set('n', "<leader><Tab>", ":FloatermToggle myfloat<CR>")
keymap.set('n', "<Tab><leader>", ":FloatermToggle myfloat<CR>")
keymap.set('t', "<leader><Tab>", "<C-\\><C-n>:q<CR>")
keymap.set('t', "<Tab><leader>", "<C-\\><C-n>:q<CR>")
