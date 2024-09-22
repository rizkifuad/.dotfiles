local M = {}

M.setup = function(opts)
  local status_ok, flutter_tools = pcall(require, "flutter-tools")
  if not status_ok then
    return
  end

  vim.cmd [[
  " autocmd BufWritePre *.dart lua vim.lsp.buf.formatting_sync(nil, 1000)
  autocmd BufWritePost *.dart silent !tmux send-keys -t1 r
  ]]

  require("flutter-tools").setup {
    closing_tags = {
      highlight = "ErrorMsg", -- highlight for the closing tag
      prefix = ">", -- character to use for close tag e.g. > Widget
      priority = 10, -- priority of virtual text in current line
      -- consider to configure this when there is a possibility of multiple virtual text items in one line
      -- see `priority` option in |:help nvim_buf_set_extmark| for more info
      enabled = true -- set to false to disable
    },
  } -- use defaults
end

return M
