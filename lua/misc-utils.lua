local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then
        scopes["o"][key] = value
    end
end

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

opt("o", "updatetime", 250) -- update interval for gitsigns
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

vim.cmd("set colorcolumn=80")

vim.cmd("set laststatus=80")

local M = {}

function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

function M.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end
-- file extension specific tabbing
vim.cmd([[autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4]])
vim.cmd([[autocmd Filetype yaml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2]])
vim.cmd([[autocmd Filetype tf setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2]])

-- format on save
vim.cmd([[augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | lua vim.lsp.buf.format({async = false})
augroup END]])

-- use vim for commit messages
vim.cmd([[
  if has('nvim') && executable('nvr')
    let $GIT_EDITOR = "nvr --remote-wait +'set bufhidden=wipe'"
  endif
]])

return M
