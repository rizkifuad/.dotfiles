local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "user.plugins.fidget"
require "user.plugins.null-ls"


--[[ lspconfig.tsserver.setup {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/Users/rizki/.n/lib/node_modules/@vue/typescript-plugin",
        languages = { "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "typescript",
    "typescriptreact",
    "vue"
  },
} ]]

local servers = { "jsonls", "cssls", "gopls", "html", "rust_analyzer", "astro", "ts_ls" }

require("mason").setup()

local mason_lspconfig = require 'mason-lspconfig'

require("user.lsp.handlers").setup()

mason_lspconfig.setup {
  ensure_installed = servers,
}

mason_lspconfig.setup_handlers {
  function(server_name)
    local opts = {
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
    }

    local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.langs." .. server_name)
    if has_custom_opts then
      opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
    end

    lspconfig[server_name].setup(opts)
  end,
}


local mason_nvim_dap_ok, mason_nvim_dap = pcall(require, "mason-nvim-dap")
if not mason_nvim_dap_ok then
  return
end


lspconfig.sourcekit.setup({
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
})


lspconfig.dartls.setup({
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
})




mason_nvim_dap.setup {
  automatic_installation = true,
  ensure_installed = {
    'delve',
  },
}



local status_ok_nextls, nextls = pcall(require, "user.lsp.langs.nextls")
if not status_ok_nextls then
  return
end

nextls.setup({
  on_attach = require("user.lsp.handlers").on_attach,
  version = "0.6.0",
  cmd = "nextls",
  -- port = 6789
})
