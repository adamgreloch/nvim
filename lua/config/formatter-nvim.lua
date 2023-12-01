--[[ local patch_clangformat_bug = function(f)
  local o = f()
  if o.args and type(o.args) == 'table' then
    local new_args = {}
    local skip = false
    for i, v in ipairs(o.args) do
      if skip then
        skip = false
      elseif v == '-assume-filename'
        and (o.args[i + 1] == "''" or o.args[i + 1] == '""')
      then
        skip = true
      elseif type(v) ~= 'string' or not v:find('^-style=') then
        table.insert(new_args, v)
      end
    end
    o.args = new_args
  end
  return o
end ]]

local util = require "formatter.util"

local clangformat = function()
  return {
    exe = vim.fn.stdpath("data") .. '/mason/bin/clang-format',
    args = {
      "-assume-filename",
      util.escape_path(util.get_current_buffer_file_name()),
    },
    stdin = true,
    try_node_modules = true,
  }
end

require("formatter").setup({
  logging = true,
    -- Set the log level
  log_level = vim.log.levels.WARN,
  filetype = {
    cpp = { clangformat },
    latex = {
      function()
        return {
          exe = "latexindent",
          args = {
            "-g",
            "/dev/null",
          },
          stdin = true,
        }
      end
    }
  }
})

vim.cmd [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.cpp FormatWrite
  autocmd BufWritePost *.tex FormatWrite
augroup END
]]
