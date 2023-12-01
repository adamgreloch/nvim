local dap = require("dap");
local widgets = require('dap.ui.widgets');

local function open_sidebar()
  local sidebar = widgets.sidebar(widgets.scopes);
  sidebar.open();
end

dap.configurations = {
    cpp = {
      {
        type = "codelldb", -- Which adapter to use
        name = "Debug", -- Human readable name
        request = "launch", -- Whether to "launch" or "attach" to program
        program = "${file}", -- The buffer you are focused on when running nvim-dap
      },
    }
}

dap.adapters.executable = {
  type = 'executable',
  command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
  name = 'lldb1',
  host = '127.0.0.1',
  port = 13000
}

dap.adapters.codelldb = {
  name = "codelldb server",
  type = 'server',
  port = "${port}",
  executable = {
    command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
    args = { "--port", "${port}" },
  }
}

vim.keymap.set("n", "<leader>t", "<cmd>DapToggleBreakpoint<cr>", {desc = "Toggle breakpoint"})
vim.keymap.set("n", "<space>b", open_sidebar, {desc = "Open scope sidebar"})
vim.keymap.set("n", "<space>s", "<cmd>DapStepOver<cr>", {desc = "Step over"})
vim.keymap.set("n", "<space>i", "<cmd>DapStepInto<cr>", {desc = "Step into"})
vim.keymap.set("n", "<space>o", "<cmd>DapStepOut<cr>", {desc = "Step into"})
