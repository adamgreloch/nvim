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
    run = ":MasonUpdate", -- :MasonUpdate updates registry contents
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

  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufEnter",
    run = ":TSUpdate",
    config = function()
      require('config.treesitter')
    end,
  },

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
    keys = { { "<leader>G", "<cmd>Git<cr>", desc = "Git status" } },
    config = function()
      require('config.fugitive')
    end,
  },

  { "SirVer/ultisnips",
    dependencies = { "honza/vim-snippets" },
    event = "InsertEnter"
  },

  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require('config.which-key')
    end
  },

  {
    "folke/zen-mode.nvim",
    keys = { { "<leader>g", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  {
    "folke/trouble.nvim",
    config = function()
      require('config.trouble')
    end,
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
    branch = "legacy",
    config = function()
      require("fidget").setup()
    end,
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

  -- rarely used stuff:
  -- "whonore/Coqtail",
}
