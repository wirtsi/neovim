require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "css-lsp", "cssmodules-language-server", "eslint_d", "html-lsp", "json-lsp", "lua-language-server", "markdownlint", "pyright", "tailwindcss-language-server", "terraform-ls", "tflint", "typescript-language-server", "yaml-language-server" }
})
