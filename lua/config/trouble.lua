local trouble = require("trouble");

trouble.setup {
    icons = false,
    use_diagnostic_signs = true,
}

vim.keymap.set("n", "<space>e", "<cmd>TroubleToggle<cr>", {desc = "Toggle Trouble"})
