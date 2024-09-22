local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier,
    formatting.eslint_d,
    formatting.prettier_eslint,
    formatting.protolint,
    -- formatting.black.with({ extra_args = { "--fast" } }),
    -- formatting.stylua,
    diagnostics.protolint
  },
  should_attach = function(bufnr)
    return not vim.api.nvim_buf_get_name(bufnr):match("html")
  end,
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
})
