local packer = require("packer")
local use = packer.use

-- using { } for using different branch , loading plugin with certain commands etc
return packer.startup(
    function()
        use "wbthomason/packer.nvim"
        use 'famiu/nvim-reload'

        -- color related stuff
        use "norcalli/nvim-colorizer.lua"
	use 'shaunsingh/nord.nvim'
        use 'folke/tokyonight.nvim'

        -- lang stuff
        use "nvim-treesitter/nvim-treesitter"
        use "neovim/nvim-lspconfig"
        use "hrsh7th/nvim-compe"
        use "onsails/lspkind-nvim"
        use "sbdchd/neoformat"
        use "nvim-lua/plenary.nvim"
        use "kabouzeid/nvim-lspinstall"
        use {"npxbr/glow.nvim", run = ":GlowInstall"}

        use "lewis6991/gitsigns.nvim"
        use "akinsho/nvim-bufferline.lua"
        use 'hoob3rt/lualine.nvim'
        use "windwp/nvim-autopairs"
        use "alvan/vim-closetag"
        use "folke/trouble.nvim"
        use 'editorconfig/editorconfig-vim'
        use 'mg979/vim-visual-multi'

        -- Comment
        use "terrortylor/nvim-comment"

        -- file managing , picker etc
        use "kyazdani42/nvim-tree.lua"
        use "kyazdani42/nvim-web-devicons"
        use "nvim-telescope/telescope.nvim"
        use "nvim-telescope/telescope-media-files.nvim"
        use "nvim-lua/popup.nvim"
        use "kdheepak/lazygit.nvim"


        -- misc
        use "glepnir/dashboard-nvim"
        use "tweekmonster/startuptime.vim"
        use "907th/vim-auto-save"
        use "karb94/neoscroll.nvim"
        use "kdav5758/TrueZen.nvim"
        use "folke/which-key.nvim"
        use {"lukas-reineke/indent-blankline.nvim", branch = "lua"}
    end,
    {
        display = {
            border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"}
        }
    }
)
