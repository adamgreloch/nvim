local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_enable = {
        exclude = {
          "rust_analyzer",
        }
      }
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  { "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-omni",
      "hrsh7th/cmp-calc",
    },
    config = function()
      require('config.nvim-cmp')
    end,
  },

  { "neovim/nvim-lspconfig",
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('config.lsp')
    end,
  },

  { "nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "python",
          "c",
          "cpp",
          "lua",
          "json",
          "comment",
          "ocaml",
        },
        ignore_install = {}, -- List of parsers to ignore installing
        indent = {
          enable = true,
          disable = { "rust", 'vim', 'vimdoc', 'markdown' },
        },
        highlight = {
          enable = true,                               -- false will disable the whole extension
          disable = { 'help', 'vim', 'vimdoc', 'markdown', 'rust' }, -- list of language that will be disabled
        },
      }
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = function()
      local builtin = require('telescope.builtin')
      return {
        { '<leader>ff', builtin.git_files,                                desc = "Browse project files" },
        { '<leader>fa', function() builtin.find_files({ cwd = "~" }) end, desc = "Browse homedir" },
        { '<leader>fg', function() builtin.live_grep() end,               desc = "Live grep in cwd" },
        { '<leader>fG', builtin.git_commits,                              desc = "Git commits" },
        { '<leader>B',  builtin.buffers,                                  desc = "Go to buffer" },
        { '<leader>fh', builtin.help_tags,                                desc = "Filter help tags" },
        { '<leader>F',  builtin.lsp_document_symbols,                     desc = "List LSP document symbols" },
      }
    end,
    config = function()
      require('config.telescope')
    end,
  },

  { "miikanissi/modus-themes.nvim", priority = 1000,
    config = function()
      require("modus-themes").setup({
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
          functions = {},
          variables = {},
        },
      })
      vim.cmd("colorscheme modus_vivendi")
      vim.api.nvim_set_hl(0, "@lsp.type.comment.cpp", { link = "Comment" })
    end, },

  {
    "tpope/vim-fugitive",
    event = "User InGitRepo",
    cmd = "Git",
    keys = { { "<leader>G", "<cmd>Git<cr>", desc = "Git status" } },
    config = function()
      require('config.fugitive')
    end,
  },

  { "jamessan/vim-gnupg" },

  { "lervag/vimtex",      ft = "tex" },

  { "rust-lang/rust.vim", ft = "rust" },

  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false,   -- This plugin is already lazy
    config = function() require('config.rust-tools') end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = { { '<space>n', '<cmd>Neotree toggle<cr>', desc = "Open Neotree" } },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function() require('config.neo-tree') end,
  },

  {
    "j-hui/fidget.nvim",
    tag = "v1.4.5",
    opts = {
      progress = {
        ignore = { "pylsp", "ltex-ls" },
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    -- event = "User InGitRepo",
    -- cmd = "GitSigns",
    -- FIXME User InGitRepo never fires
    priority = 0,
    config = function()
      require('gitsigns').setup()
    end
  },
  {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {
        default_mappings = true,
      }
    end
  },

  -- massively degrades performance on markdown files, wth?
  -- "andymass/vim-matchup",

  {
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },
}
