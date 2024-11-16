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
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    config = function()
      require('config.mason')
    end,
  },
  { "williamboman/mason-lspconfig.nvim" },

  { "hrsh7th/nvim-cmp",
    dependencies = {
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-omni",
      "hrsh7th/cmp-calc",
      -- "quangnguyen30192/cmp-nvim-ultisnips",
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

  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   event = "BufEnter",
  --   build = ":TSUpdate",
  --   config = function()
  --     require('config.treesitter')
  --   end,
  -- },

  { "simnalamburt/vim-mundo",
    cmd = { "MundoToggle", "MundoShow" }
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

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require('config.statusline')
    end,
  },

  { "rebelot/kanagawa.nvim" },

  {
    "tpope/vim-fugitive",
    event = "User InGitRepo",
    cmd = "Git",
    keys = { { "<leader>G", "<cmd>Git<cr>", desc = "Git status" } },
    config = function()
      require('config.fugitive')
    end,
  },

  { "SirVer/ultisnips",
    dependencies = { "honza/vim-snippets" },
    event = "InsertEnter"
  },

  { "rhysd/vim-llvm" },

  -- bugged
  -- {
  --   "folke/which-key.nvim",
  --   config = function()
  --     vim.o.timeout = true
  --     vim.o.timeoutlen = 300
  --     require('config.which-key')
  --   end
  -- },

  {
    "folke/zen-mode.nvim",
    keys = { { "<leader>g", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = { { "<space>e", "<cmd> Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" } },
    opts = {},
  },

  {
    "mhartington/formatter.nvim",
    config = function() require('config.formatter-nvim') end,
    cmd = { "Format", "FormatWrite" },
  },

  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function() require('config.hop') end,
  },

  { "gelguy/wilder.nvim" },

  { "numToStr/Comment.nvim",
    opts = {}
  },

  { "jamessan/vim-gnupg" },

  { "lervag/vimtex",      ft = "tex" },

  { "rust-lang/rust.vim", ft = "rust" },

  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
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

  { "neovimhaskell/haskell-vim", ft = "haskell" },

  {
    "lewis6991/gitsigns.nvim",
    event = "User InGitRepo",
    cmd = { "Gitsigns" },
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

  "andymass/vim-matchup",
  { "dbmrq/vim-ditto",
    cmd = { "Ditto" }
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

  -- {
  --   "jhofscheier/ltex-utils.nvim",
  --   dependencies = {
  --     "neovim/nvim-lspconfig",
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   opts = {},
  -- },

  -- rarely used stuff:
  -- "whonore/Coqtail",
}
