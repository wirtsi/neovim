local g = vim.g
g.mapleader = " "
local cmd = vim.cmd
g.auto_save = 0

g.floaterm_width = 0.8
g.floaterm_height = 0.8
g.floaterm_title = '|👾 ($1/$2)|'

cmd "syntax on"


-- load all plugins
require "pluginList"
require("github-theme").setup({
  theme_style = "dark",
  -- other config
})
require "nvim-reload"
require "misc-utils"

require "top-bufferline"

require "statusline"

require("colorizer").setup()
require("neoscroll").setup() -- smooth scroll

require("multiline")

-- lsp stuff
require "nvim-lspconfig"
require "compe-completion"
require "true-zen"


-- blankline

g.indentLine_enabled = 1
g.indent_blankline_char = "▏"

g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
g.indent_blankline_buftype_exclude = {"terminal"}

g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_first_indent_level = false
g.wrap=1

-- project rooter
require "treesitter-nvim"
require "mappings"

require "telescope-nvim"
require "nvimTree" -- file tree stuff

-- git signs , lsp symbols etc
require "gitsigns-nvim"
require("nvim-autopairs").setup()
require("lspkind").init()

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
require "dashboard"
require("nvim_comment").setup()
