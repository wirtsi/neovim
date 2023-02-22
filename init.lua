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
map("t", "<C-ä>", [[<C-\><C-n><cmd>lua require('maximize').toggle()<cr>]], opts)
map("t", "<C-w><up>", [[<cmd>wincmd k<cr>]], opts)
map("t", "<C-w><down>", [[<cmd>wincmd k<cr>]], opts)
map("t", "<C-w><left>", [[<cmd>wincmd h<cr>]], opts)
map("t", "<C-w><right>", [[<cmd>wincmd l<cr>]], opts)
map("t", "<C-+>", [[<C-\><C-n><cmd>20winc +<cr>i]], opts)
map("t", "<C-->", [[<C-\><C-n><cmd>20winc -<cr>i]], opts)

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
vim.cmd([[autocmd BufEnter term://* startinsert]])


-- Reload nerd tree when coming from lazygit
vim.cmd([[autocmd FocusGained * NvimTreeRefresh]], false)

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
  { "shaunsingh/nord.nvim" },
  { "projekt0n/github-nvim-theme" },
  { "folke/tokyonight.nvim",
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme("tokyonight-moon")
    end
  },
  { "nvim-lualine/lualine.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      local config = require("lualine-config")
      require("lualine").setup(config)
    end
  },
  { "karb94/neoscroll.nvim",    config = true },
  { "nvim-tree/nvim-tree.lua",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
    config = require("nvimtree-config"),
    keys = {
      { "<Leader>n", "<CMD>NvimTreeToggle<CR>", mode = { "n" } },
    },
    lazy = false
  },
  { "ethanholz/nvim-lastplace", config = true },
  { "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<Leader>ff", "<CMD>Telescope find_files<CR>",  mode = { "n" } },
      { "<Leader>fw", "<CMD>Telescope live_grep<CR>",   mode = { "n" } },
      { "<Leader>fW", "<CMD>Telescope grep_string<CR>", mode = { "n" } },
      { "<Leader>fb", "<CMD>Telescope buffers<CR>",     mode = { "n" } },
      { "<Leader>f",  "<CMD>Telescope oldfiles<CR>",    mode = { "n" } },
      { "<Leader>c",  "<CMD>Telescope commands<CR>",    mode = { "n" } },
      { "<Leader>r",  "<CMD>Telescope resume<CR>",      mode = { "n" } },
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
          "typescript",
          "graphql"
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
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<S-CR>",
            node_decremental = "<BS>",
          },
        },
      }
    end },
  { "terrortylor/nvim-comment",
    keys = {
      { "<C-#>", "<CMD>CommentToggle<CR>j",             mode = { "n" } },
      { "<C-#>", "<C-\\><C-N><CMD>CommentToggle<CR>ji", mode = { "i" } },
      { "<C-#>", ":'<,'>CommentToggle<CR>gv<esc>j",     mode = { "v" } },
    },
    config = function()
      require("nvim_comment").setup()
    end,
  },
  { "fedepujol/move.nvim",
    keys = {
      { "<A-Down>", ":MoveLine(1)<CR>",              mode = { "n" } },
      { "<A-Up>",   ":MoveLine(-1)<CR>",             mode = { "n" } },
      { "<A-Down>", ":MoveBlock(1)<CR>",             mode = { "v" } },
      { "<A-Up>",   ":MoveBlock(-1)<CR>",            mode = { "v" } },
      { "<A-Down>", "<C-\\><C-N>:MoveLine(1)<CR>i",  mode = { "i" } },
      { "<A-Up>",   "<C-\\><C-N>:MoveLine(-1)<CR>i", mode = { "i" } },
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
      },
      watch_gitdir = {
        interval = 100
      },
      sign_priority = 5,
      status_formatter = nil -- Use default
    },
    keys = {
      { "<leader>bl", '<cmd>lua require("gitsigns").blame_line()<CR>', mode = { "n" } }
    },
    lazy = false
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
      -- { "<C-ä>",     "<Cmd>ToggleTermToggleAll<CR>" },
      { "th",         "<Cmd>exe v:count 1 . \"ToggleTerm direction=horizontal\"<CR>" },
      { "tv",         "<Cmd>exe v:count 1 . \"ToggleTerm direction=vertical size=40\"<CR>" },
      { "tt",         "<Cmd>exe v:count 1 . \"ToggleTerm direction=float\"<CR>" }
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
  { 'romgrk/barbar.nvim',
    requires = 'nvim-web-devicons',
    lazy = false,
    init = function()
      local nvim_tree_events = require('nvim-tree.events')
      local bufferline_api = require('bufferline.api')

      local function get_tree_size()
        return require 'nvim-tree.view'.View.width
      end

      nvim_tree_events.subscribe('TreeOpen', function()
        bufferline_api.set_offset(get_tree_size())
      end)

      nvim_tree_events.subscribe('Resize', function()
        bufferline_api.set_offset(get_tree_size())
      end)

      nvim_tree_events.subscribe('TreeClose', function()
        bufferline_api.set_offset(0)
      end)
    end,

    config = {
      icons = 'both',
      icon_separator_active = '▎',
      icon_separator_inactive = '▎',
      icon_close_tab = '',
      icon_close_tab_modified = '●',
      icon_pinned = '車',
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = 'ﬀ' },
        [vim.diagnostic.severity.WARN] = { enabled = false },
        [vim.diagnostic.severity.INFO] = { enabled = false },
        [vim.diagnostic.severity.HINT] = { enabled = true },
      },
    },
    keys = {
      { "bn",              "<Cmd>tabnew<CR>" },
      { "bq",              "<Cmd>BufferClose<CR>" },
      { "bp",              "<Cmd>BufferPin<CR>" },
      { "<TAB>",           "<Cmd>BufferNext<CR>" },
      { "<S-TAB>",         "<Cmd>BufferPrevious<CR>" },
      { "<leader><right>", "<Cmd>BufferNext<CR>" },
      { "<leader><left>",  "<Cmd>BufferPrevious<CR>" },
      { "<leader>1",       "<Cmd>BufferGoto 1<CR>" },
      { "<leader>2",       "<Cmd>BufferGoto 2<CR>" },
      { "<leader>3",       "<Cmd>BufferGoto 3<CR>" },
      { "<leader>4",       "<Cmd>BufferGoto 4<CR>" },
      { "<leader>5",       "<Cmd>BufferGoto 5<CR>" },
      { "<leader>6",       "<Cmd>BufferGoto 6<CR>" },
      { "<leader>7",       "<Cmd>BufferGoto 7<CR>" },
      { "<leader>8",       "<Cmd>BufferGoto 8<CR>" },
      { "<leader>9",       "<Cmd>BufferGoto 9<CR>" },
    }
  },
  { "norcalli/nvim-colorizer.lua",   config = true, lazy = false },
  { "windwp/nvim-autopairs",         lazy = false,  config = true },
  { "alvan/vim-closetag",            lazy = false },
  { "907th/vim-auto-save",           lazy = false },
  { 'editorconfig/editorconfig-vim', lazy = false },
  {
    'declancm/maximize.nvim', lazy = false,
    config = function()
      require('maximize').setup({ default_keymaps = false })
    end,
    keys = {
      { "<C-ä>", "<Cmd>lua require('maximize').toggle()<CR>" },
    }
  }
}
