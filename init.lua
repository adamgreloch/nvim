vim.loader.enable()

local core_conf_files = {
  "globals.lua",      -- some global settings
  "options.vim",      -- setting options in nvim
  "autocommands.vim", -- various autocommands
  "plugins.vim",      -- all the plugins installed and their configurations
  "mappings.lua",     -- all the user-defined mappings
  "colorscheme.lua",  -- colorscheme settings
}

-- source all the core config files
for _, name in ipairs(core_conf_files) do
  local path = string.format("%s/core/%s", vim.fn.stdpath("config"), name)
  local source_cmd = "source " .. path
  vim.cmd(source_cmd)
end
