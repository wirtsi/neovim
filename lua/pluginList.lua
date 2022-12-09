local packer = require("packer")
local use = packer.use

-- using { } for using different branch , loading plugin with certain commands etc
return packer.startup(
  function()
    use "wbthomason/packer.nvim"
    use 'famiu/nvim-reload'

    -- color related stuff
    use 'shaunsingh/nord.nvim'
    use 'folke/tokyonight.nvim'
    use "projekt0n/github-nvim-theme"
    use "norcalli/nvim-colorizer.lua"

    -- lang stuff
    use "nvim-treesitter/nvim-treesitter"
    use "hrsh7th/nvim-compe"
    use "nvim-lua/plenary.nvim"
    use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    }
    use "jose-elias-alvarez/null-ls.nvim"
    use "jose-elias-alvarez/nvim-lsp-ts-utils"
    -- use { "npxbr/glow.nvim", run = ":GlowInstall" }

    use "lewis6991/gitsigns.nvim"
    use "akinsho/nvim-bufferline.lua"
    use 'hoob3rt/lualine.nvim'
    use "windwp/nvim-autopairs"
    use "alvan/vim-closetag"
    use 'editorconfig/editorconfig-vim'
    use 'mg979/vim-visual-multi'
    use 'edgedb/edgedb-vim'

    -- Comment
    use "terrortylor/nvim-comment"

    -- file managing , picker etc
    use {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
    }
    use "kyazdani42/nvim-web-devicons"
    use "nvim-telescope/telescope.nvim"
    -- use "nvim-telescope/telescope-file-browser.nvim"
    -- use "nvim-telescope/telescope-media-files.nvim"
    use "nvim-lua/popup.nvim"
    use {
      "kdheepak/lazygit.nvim",
      config = function()
        local g = vim.g
        -- g.lazygit_floating_window_use_plenary = true
        -- g.lazygit_floating_window_winblend = 0
      end,
    }
    -- misc
    use "glepnir/dashboard-nvim"
    use "tweekmonster/startuptime.vim"
    use "907th/vim-auto-save"
    use "karb94/neoscroll.nvim"
    use "folke/which-key.nvim"
    use "lukas-reineke/indent-blankline.nvim"
    use "ggandor/leap.nvim"
    use {
      'voldikss/vim-floaterm',
      opt = true,
      cmd = { 'FloatermToggle', 'FloatermNew', 'FloatermSend' },
      config = function()
        local g = vim.g

        g.floaterm_width = 0.8
        g.floaterm_height = 0.8
        g.floaterm_title = '|👾 ($1/$2)|'
        g.floaterm_opener = 'vsplit'
      end,
    }
  end,
  {
    display = {
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
    }
  }
)
