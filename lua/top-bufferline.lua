require "bufferline".setup {
    options = {
        offsets = {{filetype = "NvimTree", text = "", padding = 1}},
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
}

local opt = {silent = true}
local map = vim.api.nvim_set_keymap
vim.g.mapleader = " "

-- MAPPINGS
map("n", "bn", [[<Cmd>tabnew<CR>]], opt) -- new tab
map("n", "bq", [[<Cmd>bdelete<CR> | BufferLineCycleNext<CR>]], opt) -- close tab

-- move between tabs
map("n", "<TAB>", [[<Cmd>BufferLineCycleNext<CR>]], opt)
map("n", "<S-TAB>", [[<Cmd>BufferLineCyclePrev<CR>]], opt)
map("n", "<leader><right>", [[<Cmd>BufferLineCycleNext<CR>]], opt)
map("n", "<leader><left>", [[<Cmd>BufferLineCyclePrev<CR>]], opt)
map("n", "<leader>1", [[<Cmd>BufferLineGoToBuffer 1<CR>]], opt)
map("n", "<leader>2", [[<Cmd>BufferLineGoToBuffer 2<CR>]], opt)
map("n", "<leader>3", [[<Cmd>BufferLineGoToBuffer 3<CR>]], opt)
map("n", "<leader>4", [[<Cmd>BufferLineGoToBuffer 4<CR>]], opt)
map("n", "<leader>5", [[<Cmd>BufferLineGoToBuffer 5<CR>]], opt)
map("n", "<leader>6", [[<Cmd>BufferLineGoToBuffer 6<CR>]], opt)
map("n", "<leader>7", [[<Cmd>BufferLineGoToBuffer 7<CR>]], opt)
map("n", "<leader>8", [[<Cmd>BufferLineGoToBuffer 8<CR>]], opt)
map("n", "<leader>9", [[<Cmd>BufferLineGoToBuffer 9<CR>]], opt)
