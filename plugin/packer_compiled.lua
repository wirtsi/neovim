-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/floriankrause/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/floriankrause/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/floriankrause/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/floriankrause/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/floriankrause/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["TrueZen.nvim"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/TrueZen.nvim"
  },
  ["dashboard-nvim"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/dashboard-nvim"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/editorconfig-vim"
  },
  ["github-nvim-theme"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/github-nvim-theme"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["glow.nvim"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/glow.nvim"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["lazygit.nvim"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/lazygit.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  neoformat = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/neoformat"
  },
  ["neoscroll.nvim"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/neoscroll.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-bufferline.lua"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-comment"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/nvim-comment"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-reload"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/nvim-reload"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n’\3\0\0\6\0\16\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0025\3\5\0004\4\0\0=\4\6\3=\3\a\0025\3\b\0004\4\0\0=\4\t\3=\3\n\0025\3\v\0005\4\f\0004\5\0\0=\5\r\4=\4\14\3=\3\15\2B\0\2\1K\0\1\0\tview\rmappings\tlist\1\0\1\16custom_only\1\1\0\3\tside\tleft\nwidth\3\30\16auto_resize\1\16system_open\targs\1\0\0\24update_focused_file\16ignore_list\1\0\2\15update_cwd\1\venable\1\23ignore_ft_on_setup\1\0\b\15auto_close\1\20lsp_diagnostics\1\15update_cwd\1\18hijack_cursor\1\16open_on_tab\1\18open_on_setup\1\17hijack_netrw\2\18disable_netrw\2\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["project.nvim"] = {
    config = { "\27LJ\2\n>\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\17project_nvim\frequire\0" },
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/project.nvim"
  },
  ["startuptime.vim"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/startuptime.vim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\15auto_close\2\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  ["vim-auto-save"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/vim-auto-save"
  },
  ["vim-closetag"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/vim-closetag"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/vim-visual-multi"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/Users/floriankrause/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n’\3\0\0\6\0\16\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0025\3\5\0004\4\0\0=\4\6\3=\3\a\0025\3\b\0004\4\0\0=\4\t\3=\3\n\0025\3\v\0005\4\f\0004\5\0\0=\5\r\4=\4\14\3=\3\15\2B\0\2\1K\0\1\0\tview\rmappings\tlist\1\0\1\16custom_only\1\1\0\3\tside\tleft\nwidth\3\30\16auto_resize\1\16system_open\targs\1\0\0\24update_focused_file\16ignore_list\1\0\2\15update_cwd\1\venable\1\23ignore_ft_on_setup\1\0\b\15auto_close\1\20lsp_diagnostics\1\15update_cwd\1\18hijack_cursor\1\16open_on_tab\1\18open_on_setup\1\17hijack_netrw\2\18disable_netrw\2\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: project.nvim
time([[Config for project.nvim]], true)
try_loadstring("\27LJ\2\n>\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\17project_nvim\frequire\0", "config", "project.nvim")
time([[Config for project.nvim]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\15auto_close\2\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
