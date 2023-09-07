local hop = require("hop")
hop.setup { keys = 'etovxqpdygfblzhckisuran' }

vim.keymap.set("n", "<space><space>", "<cmd>HopWord<cr>", { desc = "Hop to a word" })
