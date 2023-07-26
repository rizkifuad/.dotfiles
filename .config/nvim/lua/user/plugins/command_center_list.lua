local command_center = require("command_center")
local noremap = { noremap = true }

-- Or you can set up the category for multiple commands at once
command_center.add({
  {
    description = "Open git diffview",
    cmd = "<CMD>DiffviewOpen<CR>",
    keybindings = { "n", "<leader>gd", noremap },
  }, {
  description = "Close current git diffview",
  cmd = "<CMD>DiffviewClose<CR>",
  keybindings = { "n", "<leader>gc", noremap },
}, {
  -- category set in a smaller scope takes precedence
  description = "Toggle markdown preview",
  cmd = "<CMD>MarkdownPreviewToggle<CR>",
  keybindings = { "n", "<leader>mp", noremap },
  category = "markdown",
},
  {
    -- If keys are specified,
    -- then they will still show up in command_center but won't be registered
    desc = "Find hidden files",
    cmd = "<CMD>Telescope find_files hidden=true<CR>",
    keys = { "n", "<c-p>", noremap },
  }, {
  desc = "Show document symbols",
  cmd = "<CMD>Telescope lsp_document_symbols<CR>",
}, {
  -- The mode can be even further overridden within each item
  desc = "LSP code actions",
  cmd = "<CMD>Telescope lsp_code_actions<CR>",
  keybinginds = { "n", "<leader>ca", noremap },
  mode = command_center.mode.ADD_SET,
},
  {
    desc = "Find files",
    cmd = "<CMD>Telescope find_files<CR>",
    keys = { "n", "<leader>f", { noremap = true } },
  },
  {
    -- If keys is not specified, then this enery is ignored
    -- since there is no keymaps to set
    desc = "Search inside current buffer",
    cmd = "<CMD>Telescope current_buffer_fuzzy_find<CR>",
  },
  {
    desc = "Format current buffer",
    cmd = "<CMD>lua vim.lsp.buf.format()<CR>",
  },
  {
    desc = "Minify JSON",
    cmd = "<CMD>silent %!jq -r tostring<CR>",
  }
}, {
  mode = command_center.mode.ADD_ONLY,
})
