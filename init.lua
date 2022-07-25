local g = vim.g
g.mapleader = " "
local cmd = vim.cmd
g.auto_save = 0
g.wrap=1
g.pumblend = 0
cmd "syntax on"


-- load all plugins
require "pluginList"
cmd[[colorscheme tokyonight]]

-- require("github-theme").setup({
--   theme_style = "dark",
--   -- other config
-- })
require "nvim-reload"
require "misc-utils"

require "top-bufferline"

require "statusline"

require("colorizer").setup()
require("neoscroll").setup() -- smooth scroll

require("multiline")
require "indent-blankline"

-- lsp stuff
require "mason-config"
require "nvim-lspconfig"
require "compe-completion"
require "true-zen"


-- project rooter
require "treesitter-nvim"
require "mappings"

require "telescope-nvim"
require "nvimTree" -- file tree stuff

-- git signs , lsp symbols etc
require "gitsigns-nvim"
require("nvim-autopairs").setup()

-- hide line numbers , statusline in specific buffers!
vim.cmd(
    [[
   au BufEnter term://* setlocal nonumber
   au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
   au BufEnter term://* set laststatus=0 
]],
    false
)

-- notify file change
vim.cmd([[autocmd FocusGained * checktime]], false)

require "whichkey"
require("nvim_comment").setup()
require("dashboard-config")
