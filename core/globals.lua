------------------------------------------------------------------------
--                         builtin variables                          --
------------------------------------------------------------------------
vim.g.loaded_perl_provider = 0      -- Disable perl provider
vim.g.loaded_ruby_provider = 0      -- Disable ruby provider
vim.g.loaded_node_provider = 0      -- Disable node provider
vim.g.did_install_default_menus = 1 -- do not load menu

-- Enable highlighting for lua HERE doc inside vim script
vim.g.vimsyn_embed = 'l'

-- Use English as main language
vim.cmd [[language en_US.UTF-8]]

-- Disable loading certain plugins

-- Do not load tohtml.vim
vim.g.loaded_2html_plugin = 1

-- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all these plugins are
-- related to checking files inside compressed files)
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1

-- Do not load the tutor plugin
vim.g.loaded_tutor_mode_plugin = 1

-- Do not use builtin matchit.vim and matchparen.vim since we use vim-matchup
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1

-- Disable sql omni completion, it is broken.
vim.g.loaded_sql_completion = 1

-- Disable cursor theming
vim.opt.guicursor = "n-v-c-i:block"

vim.g.signcolumn = "yes"

-- Set textwidth
vim.opt.textwidth = 80

-- Disable recommended markdown style
vim.g.markdown_recommended_style = 0


-- TODO move somewhere

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if vim.tbl_contains({ 'null-ls' }, client.name) then -- blacklist lsp
      return
    end
    require("lsp_signature").on_attach({
      hint_enable = false
    }, bufnr)
  end,
})
