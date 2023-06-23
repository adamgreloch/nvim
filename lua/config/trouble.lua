local trouble = require("trouble");

trouble.setup {
    icons = false,
    use_diagnostic_signs = true,
}

vim.keymap.set("n", "<leader>t", "<cmd>TroubleToggle<cr>", {desc = "Toggle Trouble"})
