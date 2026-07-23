local M = {}

M.setup = function()
  local status_ok, codeium = pcall(require, "codeium")
  if not status_ok then
    return
  end
end
codeium.setup({})

return M
