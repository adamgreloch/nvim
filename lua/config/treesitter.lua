require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "python",
    "c",
    "cpp",
    "lua",
    "json",
    "rust",
    "comment",
    "ocaml",
  },
  ignore_install = {}, -- List of parsers to ignore installing
  indent = {
    enable = true,
    disable = { "rust", 'vim', 'vimdoc' },
  },
  highlight = {
    enable = true,        -- false will disable the whole extension
    disable = { 'help', 'vim', 'vimdoc', 'markdown' }, -- list of language that will be disabled
  },
}
