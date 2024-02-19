require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "python",
    "c",
    "cpp",
    "lua",
    "vim",
    "json",
    "rust",
    "comment",
    "ocaml",
  },
  ignore_install = {}, -- List of parsers to ignore installing
  indent = {
    enable = true,
    disable = { "rust" },
  },
  highlight = {
    enable = true,        -- false will disable the whole extension
    disable = { 'help', 'vimdoc', 'markdown' }, -- list of language that will be disabled
  },
}
