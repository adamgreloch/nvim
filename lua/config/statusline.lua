local utils = require('lualine.utils.utils')

local colors = {
  silver     = '#c0c0c0',
  red        = '#ff0000',
  my_fg      = utils.extract_color_from_hllist('fg', { 'Normal' }, '#000000'),
  my_bg      = utils.extract_color_from_hllist('bg', { 'StatusLineNC' }, '#ffffff'),
  my_cool_bg = utils.extract_color_from_hllist('bg', { 'WildMenu' }, '#d7d7ff'),
  visual     = utils.extract_color_from_hllist('bg', { 'Visual' }, '#000000'),
  type     = utils.extract_color_from_hllist('fg', { 'Type' }, '#000000'),
}

local M = {
  normal = {
    a = { fg = colors.my_fg, bg = colors.my_bg, gui = 'bold' },
    b = { fg = colors.my_fg, bg = colors.my_bg },
    c = { fg = colors.my_fg, bg = colors.my_bg },
  },
  insert = { a = { fg = colors.my_bg, bg = colors.type, gui = 'bold' } },
  visual = { a = { fg = colors.my_fg, bg = colors.visual, gui = 'bold' } },
  replace = { a = { fg = colors.my_fg, bg = colors.red, gui = 'bold' } },
  inactive = {
    a = { fg = colors.silver, bg = colors.my_bg, gui = 'bold' },
    b = { fg = colors.gray, bg = colors.my_bg },
    c = { fg = colors.silver, bg = colors.my_bg },
  },
}

-- Default lualine config
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = { "quickfix", "fugitive", "nvim-tree" }
}
