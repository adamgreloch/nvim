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
      { "neovim/nvim-lspconfig",
        config = function()
          require('config.lsp')
        end,
      },
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

  {
    "mfussenegger/nvim-lint",
    lazy = false,
    config = function()
      require('lint').linters_by_ft = {
        sh = { 'shellcheck' }
      }
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
          enable = true,                                             -- false will disable the whole extension
          disable = { 'help', 'vim', 'vimdoc', 'markdown', 'rust' }, -- list of language that will be disabled
        },
      }
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require 'lsp_signature'.setup(opts)
    end
  },

  { "bogado/file-line" },

  { "simnalamburt/vim-mundo",
    cmd = { "MundoToggle", "MundoShow" }
  },

  { "sindrets/diffview.nvim" },


  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = function()
      local builtin = require('telescope.builtin')
      local git_files_from_superproject = function(opts)
        opts = opts or {}
        opts.cwd = vim.fn.systemlist("git rev-parse --show-superproject-working-tree")[1]
        builtin.find_files(opts)
      end
      return {
        { '<leader>tt',       builtin.git_files,                                desc = "Find git files" },
        { '<leader><leader>', git_files_from_superproject,                      desc = "Find files from superproject" },
        { '<leader>ta',       function() builtin.find_files({ cwd = "~" }) end, desc = "Browse homedir" },
        { '<leader>tg',       function() builtin.live_grep() end,               desc = "Live grep in cwd" },
        { '<leader>tG',       builtin.git_commits,                              desc = "Git commits" },
        { '<leader>B',        builtin.buffers,                                  desc = "Go to buffer" },
        { '<leader>th',       builtin.help_tags,                                desc = "Filter help tags" },
        { '<leader>T',        builtin.lsp_document_symbols,                     desc = "List LSP document symbols" },
      }
    end,
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            mappings = {
              n = {
                ["cd"] = function(prompt_bufnr)
                  local selection = require("telescope.actions.state").get_selected_entry()
                  local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                  require("telescope.actions").close(prompt_bufnr)
                  -- Depending on what you want put `cd`, `lcd`, `tcd`
                  vim.cmd(string.format("silent lcd %s", dir))
                end
              }
            }
          },
        },
      }
    end,
  },

  {
    "miikanissi/modus-themes.nvim",
    priority = 1000,
    config = function()
      require('config.modus')
    end,
  },

  {
    "tpope/vim-fugitive",
    -- event = "User InGitRepo",
    -- cmd = "Git",
    lazy = false,
    keys = { { "<leader>g", "<cmd>Git<cr>", desc = "Git status" } },
    config = function()
      require('config.fugitive')
    end,
  },


  { "jamessan/vim-gnupg" },

  { "lervag/vimtex",      ft = "tex" },

  { "rust-lang/rust.vim", ft = "rust" },

  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require('config.which-key')
    end
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false,   -- This plugin is already lazy
    config = function() require('config.rustaceanvim') end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = { { '<leader>n', '<cmd>Neotree toggle<cr>', desc = "Open Neotree" } },
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


  { "neovimhaskell/haskell-vim", ft = "haskell" },

  {
    "lewis6991/gitsigns.nvim",
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
