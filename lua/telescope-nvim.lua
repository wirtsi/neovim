-- require("telescope").load_extension('projects')
require('telescope').setup {
  defaults = {
  }
}

local opt = { noremap = true, silent = true }

vim.g.mapleader = " "

-- mappings
vim.api.nvim_set_keymap("n", "<Leader>ff", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fb", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fh", [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fo", [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>r", [[<Cmd>lua require('telescope.builtin').resume()<CR>]], opt)

-- dashboard stuff
vim.api.nvim_set_keymap("n", "<Leader>fw", [[<Cmd> Telescope live_grep<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fW", [[<Cmd> Telescope grep_string<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fn", [[<Cmd> DashboardNewFile<CR>]], opt)
-- vim.api.nvim_set_keymap("n", "<Leader>fp", [[<Cmd> Telescope projects<CR>]], opt)
-- vim.api.nvim_set_keymap("n", "<Leader>fB", [[<Cmd> Telescope file_browser<CR>]], opt)

vim.api.nvim_set_keymap("n", "<Leader>bm", [[<Cmd> DashboardJumpMarks<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>sl", [[<Cmd> SessionLoad<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>ss", [[<Cmd> SessionSave<CR>]], opt)
