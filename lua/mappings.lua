 local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

-- dont copy any deleted text , this is disabled by default so uncomment the below mappings if you want them!

map("n", "dd", [=[ "_dd ]=], opt)
map("v", "dd", [=[ "_dd ]=], opt)
map("v", "x", [=[ "_x ]=], opt)

-- OPEN TERMINALS --
-- map("n", "<C-l>", [[<Cmd>vnew term://fish <CR>]], opt) -- term over right
-- map("n", "<C-x>", [[<Cmd> split term://fish | resize 10 <CR>]], opt) --  term bottom
-- map("n", "<C-t>t", [[<Cmd> tabnew | term <CR>]], opt) -- term newtab

-- COPY EVERYTHING --
-- map("n", "<C-a>", [[ <Cmd> %y+<CR>]], opt)

-- toggle numbers ---
-- map("n", "<leader>nn", [[ <Cmd> set nu!<CR>]], opt)

-- map("n", "<C-s>", [[ <Cmd> w <CR>]], opt)
-- vim.cmd("inoremap jh <Esc>")

-- Commenter Keybinding
map("n", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
map("v", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})

-- LazyGit
map("n", "<leader>lg", ":LazyGit<CR>",{noremap = true, silent = true})

-- Show Errors
map("n", "<leader>e", ":TroubleToggle<CR>",{noremap = true, silent = true})

-- Use cursor to select
map("c", "<down>", 'pumvisible() ? "<c-n>": "<down>"', { noremap = true, expr = true, silent = false})
map("c", "<up>", 'pumvisible() ? "<c-p>": "<up>"', { noremap = true, expr = true, silent = false})

-- line wrap
map("n", "<leader>w", ":set nowrap!<CR>",{noremap = true, silent = true})

-- preview markdown
map("n", "<leader>m", ":Glow<CR>",{noremap = true, silent = true})
-- format code
map("n", "<Leader>fm", [[<Cmd> Neoformat<CR>]], opt)
