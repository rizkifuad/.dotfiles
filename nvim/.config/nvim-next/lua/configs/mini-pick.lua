local pick = require('mini.pick')


pick.setup({
  mappings = {
    send_to_qf = {
      char = '<C-q>',
      func = function()
        pick.default_choose_marked(pick.get_picker_matches().all)
      end,
    },
  },
  window = {
    config = function()
      local screen_w = vim.o.columns
      local screen_h = vim.o.lines
      local width = math.floor(screen_w * 0.6)
      local height = math.floor(screen_h * 0.4)

      return {
        relative = 'editor',
        anchor = 'NW',
        height = height,
        width = width,
        row = math.floor((screen_h - height) / 2),
        col = math.floor((screen_w - width) / 2),

        -- Custom border array of spaces creates top, bottom, left, and right padding
        border = { " ", " ", " ", " ", " ", " ", " ", " " }
      }
    end
  },
  options = {
    show_icons = false
  },

})

local C = require("catppuccin.palettes").get_palette()

vim.api.nvim_set_hl(0, "MiniPickNormal", { bg = C.crust })
vim.api.nvim_set_hl(0, "MiniPickBorder", { fg = C.crust, bg = C.crust }) -- Match fg to bg
vim.api.nvim_set_hl(0, "MiniPickBorderText", { fg = C.crust, bg = C.lavender, bold = true })
vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { bg = C.surface0, bold = true })
vim.api.nvim_set_hl(0, 'MiniPickPrompt',       { bg = C.mantle, fg = C.overlay1 })
vim.api.nvim_set_hl(0, 'MiniPickPromptPrefix', { bg = C.crust, fg = C.surface2, bold = true })
vim.api.nvim_set_hl(0, 'MiniPickBorder',       { bg = C.mantle, fg = C.crust })
