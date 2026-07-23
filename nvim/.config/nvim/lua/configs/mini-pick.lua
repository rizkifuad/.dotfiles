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
    prompt_prefix = '  ',
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

        border = { " ", " ", " ", " ", " ", " ", " ", " " }
      }
    end
  },
})

local C = require("catppuccin.palettes").get_palette()

vim.api.nvim_set_hl(0, "MiniPickNormal", { bg = C.crust })
vim.api.nvim_set_hl(0, "MiniPickBorder", { fg = C.crust, bg = C.crust }) -- Match fg to bg
vim.api.nvim_set_hl(0, "MiniPickBorderText", { fg = C.crust, bg = C.lavender, bold = true })
vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { bg = C.surface0, bold = true })
vim.api.nvim_set_hl(0, 'MiniPickPrompt', { bg = C.crust, fg = C.overlay1 })
vim.api.nvim_set_hl(0, 'MiniPickPromptPrefix', { bg = C.crust, fg = C.surface2, bold = true })
vim.api.nvim_set_hl(0, 'MiniPickBorder', { bg = C.crust, fg = C.crust })

pick.registry.files_with_hidden = function()
  -- Add the --hidden flag to the fd command
  local command = { 'fd', '--type=f', '--no-follow', '--color=never', '--hidden', '--no-ignore-vcs', '--exclude=.git' }
  local show_with_icons = function(buf_id, items, query)
    return pick.default_show(buf_id, items, query, { show_icons = true })
  end
  local source = { name = 'Files with hidden', show = show_with_icons }

  return pick.builtin.cli({ command = command }, { source = source })
end
