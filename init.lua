-------------------------------------------------------------------------------
-- Options
-------------------------------------------------------------------------------
-- globals
vim.g.mapleader = " "
vim.g.pumblend = 0

local scopes = { o = vim.o, b = vim.bo, w = vim.wo }

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= "o" then
    scopes["o"][key] = value
  end
end

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opts = {}

-- terminal escape
-- we don't allow escaping terminal mode deliberately
map("t", "<C-+>", [[<C-\><C-n><cmd>ToggleTerm<cr>]], opts)
map("t", "<C-w><up>", [[<cmd>wincmd k<cr>]], opts)
map("t", "<C-w><down>", [[<cmd>wincmd k<cr>]], opts)
map("t", "<C-w><left>", [[<cmd>wincmd h<cr>]], opts)
map("t", "<C-w><right>", [[<cmd>wincmd l<cr>]], opts)

-- Use cursor to select
-- map("c", "<down>", 'pumvisible() ? "<c-n>": "<down>"', { noremap = true, expr = true, silent = false })
-- map("c", "<up>", 'pumvisible() ? "<c-p>": "<up>"', { noremap = true, expr = true, silent = false })

opt("o", "ruler", false)
opt("o", "showmode", false)
opt("o", "hidden", true)
opt("o", "ignorecase", true)
opt("o", "splitbelow", true)
opt("o", "splitright", true)
opt("o", "termguicolors", true)
opt("w", "cul", true)

opt("o", "mouse", "a")

opt("w", "signcolumn", "yes")
opt("o", "cmdheight", 1)

opt("o", "updatetime", 250)
opt("o", "clipboard", "unnamedplus")
opt("o", "timeoutlen", 500)

-- Numbers
opt("w", "number", true)
opt("o", "numberwidth", 2)
opt("w", "relativenumber", true)

-- for indenline
opt("b", "expandtab", true)
opt("b", "shiftwidth", 2)
opt("b", "smartindent", true)

opt("o", "updatetime", 250)

vim.cmd("set colorcolumn=80")
vim.cmd("set laststatus=80")

vim.cmd([[autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]])
vim.cmd([[autocmd Filetype yaml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2]])
vim.cmd([[autocmd Filetype tf setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2]])
-- notify file change
vim.cmd([[autocmd FocusGained * checktime]], false)

-------------------------------------------------------------------------------
-- Bootstrap Package Manager
-------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("Installing 'folke/lazy.nvim'...")
  vim.fn.system({ "git", "clone", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------
require("lazy").setup {
  { "shaunsingh/nord.nvim",
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme("nord")
    end },
  { "nvim-lualine/lualine.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      local config = require("lualine-config")
      require("lualine").setup(config)
    end
  },
  { "karb94/neoscroll.nvim", config = true },
  { "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim"
    },
    config = {
      filesystem = {
        use_libuv_file_watcher = true,
        follow_current_file = true
      }
    },
    keys = {
      { "<Leader>n", "<CMD>Neotree toggle<CR>", mode = { "n" } }
    },
  },
  { "ethanholz/nvim-lastplace", config = true },
  { "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<Leader>ff", "<CMD>Telescope find_files<CR>", mode = { "n" } },
      { "<Leader>fw", "<CMD>Telescope live_grep<CR>", mode = { "n" } },
      { "<Leader>fW", "<CMD>Telescope grep_string<CR>", mode = { "n" } },
      { "<Leader>fb", "<CMD>Telescope buffers<CR>", mode = { "n" } },
      { "<Leader>f", "<CMD>Telescope oldfiles<CR>", mode = { "n" } },
      { "<Leader>c", "<CMD>Telescope commands<CR>", mode = { "n" } },
      { "<Leader>r", "<CMD>Telescope resume<CR>", mode = { "n" } },
    },
    config = true
  },
  { "williamboman/mason.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      "jose-elias-alvarez/null-ls.nvim",
      "jay-babu/mason-null-ls.nvim",
      "nvim-lsp-ts-utils",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",
      "chrisgrieser/cmp-nerdfont",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "onsails/lspkind.nvim"
    },
    config = require("lsp-config"),
  },
  { "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "mrjones2014/nvim-ts-rainbow"
    },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "javascript",
          "html",
          "css",
          "bash",
          "lua",
          "json",
          "python",
          "php",
          "yaml",
          "vim",
          "help",
          "rust",
          "go",
          "typescript"
        },
        highlight = {
          enable = true,
          use_languagetree = true
        },
        rainbow = {
          enable = true,
          -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          max_file_lines = nil, -- Do not enable for files with more than n lines, int
          -- colors = {}, -- table of hex strings
          -- termcolors = {} -- table of colour name strings
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      }
    end },
  { "terrortylor/nvim-comment",
    keys = {
      { "<C-#>", "<CMD>CommentToggle<CR>j", mode = { "n" } },
      { "<C-#>", "<C-\\><C-N><CMD>CommentToggle<CR>ji", mode = { "i" } },
      { "<C-#>", ":'<,'>CommentToggle<CR>gv<esc>j", mode = { "v" } },
    },
    config = function()
      require("nvim_comment").setup()
    end },
  { "fedepujol/move.nvim",
    keys = {
      { "<A-Down>", ":MoveLine(1)<CR>", mode = { "n" } },
      { "<A-Up>", ":MoveLine(-1)<CR>", mode = { "n" } },
      { "<A-Down>", ":MoveBlock(1)<CR>", mode = { "v" } },
      { "<A-Up>", ":MoveBlock(-1)<CR>", mode = { "v" } },
      { "<A-Down>", "<C-\\><C-N>:MoveLine(1)<CR>i", mode = { "i" } },
      { "<A-Up>", "<C-\\><C-N>:MoveLine(-1)<CR>i", mode = { "i" } },
    } },
  { "lewis6991/gitsigns.nvim",
    config = {
      signs = {
        add = { hl = "DiffAdd", text = "▌", numhl = "GitSignsAddNr" },
        change = { hl = "DiffChange", text = "▌", numhl = "GitSignsChangeNr" },
        delete = { hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr" },
        topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
        changedelete = { hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr" }
      },
      numhl = false,
      keymaps = {
        -- Default keymap options
        noremap = true,
        buffer = true,
        ["n >"] = { expr = true, '&diff ? \']c\' : \'<cmd>lua require"gitsigns".next_hunk()<CR>\'' },
        ["n <"] = { expr = true, '&diff ? \'[c\' : \'<cmd>lua require"gitsigns".prev_hunk()<CR>\'' },
        -- ["<leader>bl"] = '<cmd>lua require"gitsigns".blame_line()<CR>'
      },
      watch_gitdir = {
        interval = 100
      },
      sign_priority = 5,
      status_formatter = nil -- Use default
    },
  },
  { "akinsho/toggleterm.nvim",
    -- config = { open_mapping = [[<leader>tt]], direction = "tab" }
    config = true,
    init = function()
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
      function _lazygit_toggle()
        lazygit:toggle()
      end
    end,
    keys = {
      { "<Leader>lg", "<cmd>lua _lazygit_toggle()<CR>" },
      { "<C-+>", "<Cmd>ToggleTermToggleAll<CR>" },
      { "<Leader>th", "<Cmd>exe v:count1 . \"ToggleTerm direction=horizontal\"<CR>" },
      { "<Leader>tv", "<Cmd>exe v:count 1. \"ToggleTerm direction=vertical size=40\"<CR>" }
    }
  },
  { "lukas-reineke/indent-blankline.nvim",
    config = {
      char = "|",
      buftype_exclude = { "terminal" },
      filetype_exclude = { "help", "terminal", "dashboard", "mason" },
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
    }

  },
  { "ggandor/leap.nvim",
    config = function()
      require("leap").set_default_keymaps()
    end
  },
  { "famiu/bufdelete.nvim",
  },
  { "akinsho/nvim-bufferline.lua",
    lazy = false,
    config = {
      options = {
        offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
        buffer_close_icon = "",
        modified_icon = "",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 20,
        show_tab_indicators = true,
        enforce_regular_tabs = false,
        view = "multiwindow",
        show_buffer_close_icons = true,
        separator_style = "thin",
        diagnostics = "nvim_diagnostic",
        numbers = "ordinal"
      }
    },
    keys = {
      { "bn", "<Cmd>tabnew<CR>" },
      { "bq", "<Cmd>Bdelete<CR>" },
      { "<TAB>", "<Cmd>BufferLineCycleNext<CR>" },
      { "<S-TAB>", "<Cmd>BufferLineCyclePrev<CR>" },
      { "<leader><right>", "<Cmd>BufferLineCycleNext<CR>" },
      { "<leader><left>", "<Cmd>BufferLineCyclePrev<CR>" },
      { "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>" },
      { "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>" },
      { "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>" },
      { "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>" },
      { "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>" },
      { "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>" },
      { "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>" },
      { "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>" },
      { "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>" },
    }
  },
  { "norcalli/nvim-colorizer.lua", config = true, lazy = false },
  { "windwp/nvim-autopairs", lazy = false, config = true },
  { "alvan/vim-closetag", lazy = false },
  { "907th/vim-auto-save", lazy = false },
  { 'editorconfig/editorconfig-vim', lazy = false }
}
