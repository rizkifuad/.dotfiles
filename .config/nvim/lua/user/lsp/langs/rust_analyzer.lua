return {
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        disabled = {"unresolved-proc-macro"}
      },
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        loadOutDirsFromCheck = true,
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true
      },
    }
  },
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true
      }),
  }
}
