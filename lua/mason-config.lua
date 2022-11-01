require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "cssls", "cssmodules_ls", "html", "jsonls", "sumneko_lua", "marksman", "pyright", "tailwindcss", "terraformls", "tflint", "tsserver", "yamlls" }
})
