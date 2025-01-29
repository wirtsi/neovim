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
map("n", "<C-x>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "Terminal (Root Dir)" })
map("n", "<S-C-x>", function()
  Snacks.terminal("/opt/homebrew/bin/fish", { cwd = LazyVim.root() })
end, { desc = "Floating Terminal (Root Dir)" })
map("n", "<leader><left>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<leader><right>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<C-#>", ":normal gcc<cr>", { desc = "Comment shortcut" })
map("n", "<C-z>", ":lua Snacks.zen.zoom()<cr>", { desc = "Zoom buffer" })
map(
  "i",
  "<C-x>",
  "<C-o>:lua Snacks.terminal(nil, {cwd = LazyVim.root()})<cr>",
  { desc = "Terminal Command", noremap = true }
)
map("i", "<C-#>", '<C-o>:lua MiniComment.operator("line")<cr>', { desc = "Comment in insert" })
map("i", "<C-z>", "<C-o>:lua Snacks.zen.zoom()<cr>", { desc = "Zoom in insert" })
map("v", "<C-#>", ":normal gcc<cr>", { desc = "Visual block comment" })
map("t", "<C-x>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<S-C-x>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<C-z>", "<C-\\><C-n>:lua Snacks.zen.zoom()<cr>i", { desc = "Zoom Terminal" })
