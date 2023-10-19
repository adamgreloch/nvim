local dap = require("dap");
local widgets = require('dap.ui.widgets');

local function open_sidebar()
  local sidebar = widgets.sidebar(widgets.scopes);
  sidebar.open();
end

vim.keymap.set("n", "<leader>t", "<cmd>DapToggleBreakpoint<cr>", {desc = "Toggle breakpoint"})
vim.keymap.set("n", "<space>b", open_sidebar, {desc = "Open scope sidebar"})
vim.keymap.set("n", "<space>s", "<cmd>DapStepOver<cr>", {desc = "Step over"})
vim.keymap.set("n", "<space>i", "<cmd>DapStepInto<cr>", {desc = "Step into"})
vim.keymap.set("n", "<space>o", "<cmd>DapStepOut<cr>", {desc = "Step into"})
