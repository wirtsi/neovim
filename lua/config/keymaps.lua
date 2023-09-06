-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end
local Util = require("lazyvim.util")
local lazyterm = function()
  Util.float_term(nil, {})
end
map("n", "<C-t>", lazyterm, { desc = "Terminal (root dir)" })
map("t", "<C-t>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("n", "<S-TAB>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<TAB>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<leader><left>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<leader><right>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<C-#>", function()
  return MiniComment.operator() .. "_"
end, { desc = "Comment shortcut", expr = true })
map("v", "<C-#>", "[[:<c-u>lua MiniComment.operator('visual')<cr>]]", { desc = "Comment shortcut" })
map("i", "<C-ä>", "<C-o>gcc", { desc = "Comment in insert" })
