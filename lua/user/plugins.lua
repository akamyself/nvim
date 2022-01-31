local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from VIM
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye" -- Delete buffers & close files without closing your windows
  use "nvim-lualine/lualine.nvim"
  use "akinsho/toggleterm.nvim" -- Help easily manage multiple terminal windows
  use "ahmedkhalf/project.nvim" -- Superior project management
  use "lewis6991/impatient.nvim" -- Improve startup time
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim" -- Greeter dashboard
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight

  -- Testing
  use "unblevable/quick-scope" -- Lightning fast left-right movement in Vim
  use "phaazon/hop.nvim" -- Neovim motion on speed
  use "norcalli/nvim-colorizer.lua" -- The fastest Neovim colorizer.
  use "karb94/neoscroll.nvim" -- Smooth scrolling neovim plugin
  use "rcarriga/nvim-notify" -- A fancy, configurable, notification manager
  use "windwp/nvim-spectre" -- A search panel, find the enemy and replace them with dark power.
  use "Shatur/neovim-session-manager" -- A simple wrapper around :mksession
  -- use "ThePrimeagen/harpoon"
  -- use "andymass/vim-matchup" -- navigate and highlight matching words (vim script)
  -- use "MattesGroeger/vim-bookmarks" -- VIM bookmarks plugin (vim script)
  -- use "lunarvim/vim-solidity" -- VIM syntax file for Solidity (vim script)
  -- use "nacro90/numb.nvim" -- Peek lines just when you intend
  -- use "monaqa/dial.nvim" -- Enhanced increment/decrement plugin
  -- use "folke/zen-mode.nvim" -- Distraction-free coding
  -- use "folke/todo-comments.nvim" -- Highlight, list and search todo comments in your projects
  -- use "kevinhwang91/nvim-bqf" -- Better quickfix window in Neovim, polish old quickfix window.
  -- use "blackCauldron7/surround.nvim" -- A surround text object plugin
  -- use "tversteeg/registers.nvim" -- preview the contents of the registers
  -- use "metakirby5/codi.vim" -- The interactive scratchpad for hackers.
  use "nyngwang/NeoZoom.lua" -- Layout-Preserving Zoomer
  -- use { 'michaelb/sniprun', run = 'bash ./install.sh'}
  -- use {
  --   "iamcco/markdown-preview.nvim",
  --   run = "cd app && npm install",
  --   ft = "markdown",
  -- }
  -- use "SmiteshP/nvim-gps"

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "lunarvim/darkplus.nvim"
  use "Shatur/neovim-ayu"
  use "navarasu/onedark.nvim"
  use "rmehri01/onenord.nvim"
  use "Mofiqul/dracula.nvim"

  -- cmp plugins
  use {"hrsh7th/nvim-cmp",
    commit = "d93104244c3834fbd8f3dd01da9729920e0b5fe7"

  } -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp" -- floating completion suggestions
  use "hrsh7th/cmp-emoji"
  use "hrsh7th/cmp-nvim-lua" -- add lua to completion suggestions
  use {
    "tzachar/cmp-tabnine",
    config = function()
      local tabnine = require "cmp_tabnine.config"
      tabnine:setup {
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
      }
    end,

    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
  }

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  -- use "filipdutescu/renamer.nvim" -- VS Code-like renaming UI
  -- use "simrat39/symbols-outline.nvim" -- A tree like view for symbols using LSP
  -- use "ray-x/lsp_signature.nvim" -- LSP signature hint as you type
  use "b0o/SchemaStore.nvim" -- Provide access to the SchemaStore catalog
  use {
    "folke/trouble.nvim", -- A pretty diagnostics, references, telescope results, quickfix and location list
    cmd = "TroubleToggle",
  }
  -- use "RRethy/vim-illuminate"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "tom-anders/telescope-vim-bookmarks.nvim"
  use "nvim-telescope/telescope-media-files.nvim"
  use "nvim-telescope/telescope-ui-select.nvim"
  use "nvim-telescope/telescope-file-browser.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "ChristianChiarulli/nvim-ts-rainbow" -- Rainbow parentheses
  use "nvim-treesitter/playground" -- View treesitter information directly in Neovim!
  -- use "windwp/nvim-ts-autotag" -- Use treesitter to auto close and auto rename HTML tag
  -- use "romgrk/nvim-treesitter-context" -- Show code context
  -- use "mizlan/iswap.nvim" -- Interactively select and swap function arguments, list elements, and more

  -- Git
  use "lewis6991/gitsigns.nvim"
  use "f-person/git-blame.nvim" -- git blame plugin
  -- use "ruifm/gitlinker.nvim" -- Plugin to generate shareable file permalinks (with line ranges) for several git web frontend hosts
  -- use "mattn/vim-gist" -- Plugin for Gist
  -- use "mattn/webapi-vim" -- VIM interface to Web API (vim script)
  -- use "https://github.com/rhysd/conflict-marker.vim"

  -- DAP
  -- use "mfussenegger/nvim-dap" -- Debug Adapter Protocol client implementation
  -- use "theHamsta/nvim-dap-virtual-text" -- Add virtual text support to nvim-dap. nvim-treesitter is used to find variable definitions
  -- use "rcarriga/nvim-dap-ui" -- A UI for nvim-dap
  -- use "Pocco81/DAPInstall.nvim" -- Manage several debuggers for Nvim-dap

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
