-- justinhj Neovim config
-- 0.12.0 or later required

-- New UI opt-in
require('vim._core.ui2').enable({})

require('configs.autocmds')
require('configs.cmds')
require('configs.options')
require('configs.keymaps')
require('configs.tabline')

-- Plugins for treesitter and lsp server management (Mason)
local gh = function(x) return 'https://github.com/' .. x end


vim.pack.add({
  { src = gh('catppuccin/nvim') },
})

require("catppuccin").setup({ styles = { diagnostics = { "undercurl" } } })
vim.cmd('colorscheme catppuccin-macchiato')

vim.pack.add({
  { src = gh('mason-org/mason.nvim') },
  { src = gh('mason-org/mason-lspconfig.nvim') },
  { src = gh('nvim-treesitter/nvim-treesitter'), version = 'main' },
})
require('configs.lsp')

-- Treesitter
require('nvim-treesitter.config').setup({
  install_dir = vim.fn.stdpath('data') .. '/site',
})

vim.pack.add({
  {src = gh('windwp/nvim-autopairs')}
})
require("nvim-autopairs").setup()

-- Quality of life plugins. Colorthemes, keymaps etc

-- Colorizer shows html and other colour encodings in their colour
vim.pack.add({
  { src = gh('NvChad/nvim-colorizer.lua') },
})

require 'colorizer'.setup {
  'css',
  'javascript',
  html = {
    mode = 'foreground',
  }
}


-- Fugitive
vim.pack.add({
  {
    src = gh('tpope/vim-fugitive'),
  } })

vim.pack.add({
  {
    src = gh('folke/flash.nvim'),
  } })
require('configs/flash')
require('configs/commander')




-- Small selection of mini plugins
vim.pack.add({
  {
    src = gh('nvim-mini/mini.nvim'),
    version = 'main',
  } })


require('mini.extra').setup()
require('mini.git').setup()
require('mini.icons').setup({
  style='none'
})
require('mini.completion').setup()
require('mini.diff').setup({
  mappings = { apply =  ''},
  view = { style = "sign", signs = {
  add = '▎', change = '▎', delete = ' '
}}})


require('configs.mini-pick')
require('mini.align').setup()
require('configs.mini-files')
require('configs.mini-clue')
require('configs.mini-statusline')
