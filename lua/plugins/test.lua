return {
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/neotest-jest", "thenbe/neotest-playwright" },
    opts = function(_, opts)
      -- table.insert(
      --   opts.adapters,
      --   require("neotest-jest")({
      --     jestCommand = "pnpm --filter @etribes/shopify-connector test --",
      --     env = { CI = true },
      --     cwd = function(path)
      --       return vim.fn.getcwd()
      --     end,
      --   })
      -- )
      table.insert(
        opts.adapters,
        require("neotest-playwright").adapter({
          options = {
            persist_project_selection = true,
            enable_dynamic_test_discovery = true,
            get_cwd = function()
              return vim.loop.cwd() .. "/packages/shops/demo"
            end,
            get_playwright_binary = function()
              return vim.loop.cwd() .. "/packages/shops/demo/node_modules/.bin/playwright"
            end,
            get_playwright_config = function()
              return vim.loop.cwd() .. "/packages/shops/demo/playwright.config.ts"
            end,
            extra_args = {
              -- filter_dir = function(name, rel_path, root)
              --   local full_path = root .. "/" .. rel_path
              --
              --   if root:match("sbot") then
              --     if full_path:match("^packages/shops/demo") then
              --       return true
              --     else
              --       return false
              --     end
              --   else
              --     return name ~= "node_modules"
              --   end
              -- end,
            },
          },
        })
      )
    end,
  },
}
