local api = vim.api
local fn = vim.fn

local utils = require("utils")

-- The root dir to install all plugins. Plugins are under opt/ or start/ sub-directory.
vim.g.plugin_home = fn.stdpath("data") .. "/site/pack/packer"

--- Install packer if it has not been installed.
--- Return:
--- true: if this is a fresh install of packer
--- false: if packer has been installed
local function packer_ensure_install()
  -- Where to install packer.nvim -- the package manager (we make it opt)
  local packer_dir = vim.g.plugin_home .. "/opt/packer.nvim"

  if fn.glob(packer_dir) ~= "" then
    return false
  end

  -- Auto-install packer in case it hasn't been installed.
  vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})

  local packer_repo = "https://github.com/wbthomason/packer.nvim"
  local install_cmd = string.format("!git clone --depth=1 %s %s", packer_repo, packer_dir)
  vim.cmd(install_cmd)

  return true
end

local fresh_install = packer_ensure_install()

-- Load packer.nvim
vim.cmd("packadd packer.nvim")

local packer = require("packer")
local packer_util = require("packer.util")

packer.startup {
  function(use)
    use { "wbthomason/packer.nvim", opt = true }

    use {
      "williamboman/mason.nvim",
      run = ":MasonUpdate", -- :MasonUpdate updates registry contents
      config = [[require('config.mason')]]
    }

    use { "williamboman/mason-lspconfig.nvim" }

    use { "onsails/lspkind-nvim" }
    -- auto-completion engine
    use { "hrsh7th/nvim-cmp", after = "lspkind-nvim", config = [[require('config.nvim-cmp')]] }

    -- nvim-cmp completion sources
    use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }
    use { "hrsh7th/cmp-path", after = "nvim-cmp" }
    use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
    use { "hrsh7th/cmp-omni", after = "nvim-cmp" }
    use { "quangnguyen30192/cmp-nvim-ultisnips", after = { "nvim-cmp", "ultisnips" } }

    -- nvim-lsp configuration (it relies on cmp-nvim-lsp, so it should be loaded after cmp-nvim-lsp).
    use { "neovim/nvim-lspconfig", after = "cmp-nvim-lsp", config = [[require('config.lsp')]] }

    use {
      "nvim-treesitter/nvim-treesitter",
      after = "nvim-lspconfig",
      event = "BufEnter",
      run = ":TSUpdate",
      config = [[require('config.treesitter')]],
    }

    use {
      "nvim-telescope/telescope.nvim",
      requires = { { "nvim-lua/plenary.nvim" } },
      config = [[require('config.telescope')]],
    }

    use {
      "nvim-lualine/lualine.nvim",
      config = [[require('config.statusline')]],
    }

    use { "rebelot/kanagawa.nvim" }

    use {
      "tpope/vim-fugitive",
      config = [[require('config.fugitive')]]
    }

    -- Snippet engine and snippet template
    use { "SirVer/ultisnips", event = "InsertEnter" }
    use { "honza/vim-snippets", after = "ultisnips" }

    use {
      "folke/which-key.nvim",
      config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require('config.which-key')
      end
    }

    use {
      "folke/zen-mode.nvim",
      config = function()
        vim.keymap.set("n", "<leader>g", "<cmd>ZenMode<cr>")
      end
    }

    use {
      "folke/trouble.nvim",
      config = [[require('config.trouble')]]
    }

    use { "sbdchd/neoformat" }

    use {
      'phaazon/hop.nvim',
      branch = 'v2', -- optional but strongly recommended
      config = [[require('config.hop')]]
    }

    use { "gelguy/wilder.nvim", opt = true, setup = [[vim.cmd('packadd wilder.nvim')]] }

    use { "jamessan/vim-gnupg" }

    use { "whonore/Coqtail" }

    use { "lervag/vimtex" }

    use { "rust-lang/rust.vim" }

    use {
      "simrat39/rust-tools.nvim",
      after = "nvim-lspconfig",
      config = [[require('config.rust-tools')]],
    }

    use {
      "mfussenegger/nvim-dap",
      config = [[require('config.nvim-dap')]]
    }

    use {
      "voldikss/vim-floaterm",
      config = [[require('config.floaterm')]]
    }
  end,
  config = {
    max_jobs = 16,
    compile_path = packer_util.join_paths(fn.stdpath("data"), "site", "lua",
    "packer_compiled.lua"),
  },
}

-- For fresh install, we need to install plugins. Otherwise, we just need to
-- require `packer_compiled.lua`.
if fresh_install then
  -- We run packer.sync() here, because only after packer.startup, can we know
  -- which plugins to install. So plugin installation should be done after the
  -- startup process.
  packer.sync()
else
  local status, _ = pcall(require, "packer_compiled")
  if not status then
    local msg = "File packer_compiled.lua not found: run PackerSync to fix!"
    vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })
  end
end

-- Auto-generate packer_compiled.lua file
api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "*/nvim/lua/plugins.lua",
  group = api.nvim_create_augroup("packer_auto_compile", { clear = true }),
  callback = function(ctx)
    local cmd = "source " .. ctx.file
    vim.cmd(cmd)
    vim.cmd("PackerCompile")
    vim.notify("PackerCompile done!", vim.log.levels.INFO, { title = "Nvim-config" })
  end,
})
