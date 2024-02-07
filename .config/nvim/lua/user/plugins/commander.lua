local status_ok, commander = pcall(require, "commander")

if not status_ok then
  return
end
local noremap = { noremap = true }

commander.setup({
  separator = "		",

  auto_replace_desc_with_cmd = false,

  components = {
    "DESC",
    "CAT",
  },
  sort_by = {
    "DESC",
    "KEYS",
    "CAT",
    "CMD"
  },
  integration = {
    telescope = {
      enable = true,
      theme = require("telescope.themes").commander
    },
    lazy = {
      enable = true,
    }
  }
})

function _G.env_to_json()
  vim.cmd("set paste")
  vim.cmd("silent g/^$/d")
  vim.cmd("silent %s/\"//g")
  vim.cmd("silent %s/=/\":\"/")
  vim.cmd("silent %s/$/\",/")
  vim.cmd("silent %s/^/\"/")
  vim.cmd("silent norm ggO{")
  vim.cmd("silent norm Go}")
  vim.cmd("set nopaste")
end

function _G.json_to_env()
  vim.cmd("set paste")
  vim.cmd("silent g/^$/d")
  vim.cmd("silent %s/\": \"/=/g")
  vim.cmd("silent %s/\"//g")
  vim.cmd("silent %s/,$//")
  vim.cmd("set nopaste")
end

commander.add({
  {
    desc = "Search inside current buffer",
    cmd = "<CMD>Telescope current_buffer_fuzzy_find<CR>",
  }, {
  -- If desc is not provided, cmd is used to replace descirption by default
  -- You can change this behavior in setup()
  desc = "Find files",
  cmd = "<CMD>Telescope find_files<CR>",
}, {
  -- If keys are not provided, no keymaps will be displayed nor set
  desc = "Find hidden files",
  cmd = "<CMD>Telescope find_files hidden=true<CR>",
}, {
  desc = "Minify JSON",
  cmd = "<CMD>silent %!jq -r tostring<CR>",
},
  {
    desc = "Format current buffer",
    cmd = "<CMD>lua vim.lsp.buf.format()<CR>",
  },
  {
    desc = "Env To JSON",
    cmd = "<CMD>lua env_to_json()<CR>",
  },
  {
    desc = "JSON To Env",
    cmd = "<CMD>lua json_to_env()<CR>",
  },
  {
    desc = "Restart LSP",
    cmd = "<CMD>LspRestart<CR>",
  },
})
