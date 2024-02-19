-- My first Nvim config. This configuration takes substantial amount of code from
-- https://github.com/jdhao/nvim-config/, so most of the credit goes to jdhao.

vim.loader.enable()

local api = vim.api
local version = vim.version

-- check if we have the latest stable version of nvim
local expected_ver = "0.9.5"
local ev = version.parse(expected_ver)
local actual_ver = version()

vim.lsp.set_log_level("debug")

if version.cmp(ev, actual_ver) ~= 0 then
  local _ver = string.format("%s.%s.%s", actual_ver.major, actual_ver.minor, actual_ver.patch)
  local msg = string.format("Unsupported nvim version: expect %s, but got %s instead!", expected_ver, _ver)
  api.nvim_err_writeln(msg)
  return
end

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
