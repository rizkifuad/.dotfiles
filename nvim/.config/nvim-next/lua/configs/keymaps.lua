local map = vim.keymap.set
local opts = function (desc)
  return { noremap = true, silent = true, nowait = false, desc = desc }
end

map('i', '<C-Space>', function() vim.lsp.completion.get() end, { desc = 'Trigger LSP completion' })

-- Explorer
map('n', '<leader>a', function() MiniFiles.open() end, { desc = 'Open MiniFiles explorer' })
map('n', '<leader>k', function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, { desc = 'Open MiniFiles explorer' })

-- Config 
map('n', '<leader><leader>l', ':luafile %<CR>', { desc = 'Lua evaluate current file' })
map('n', '<leader><leader>c', function()
  vim.cmd("tabnew")
  vim.cmd("lcd ~/.config/nvim")
  vim.cmd("edit init.lua")
end, { desc = 'Lua evaluate current file' })

-- Picker
map('n', '<C-p>', function()
  require('mini.pick').builtin.files({ tool = 'fd' })
end, opts('Pick files'))

map('n', '<Leader>f', function()
  require('mini.pick').builtin.grep_live({ tool = 'rg' })
end, opts('Pick grep_live'))


-- QoL Navigation
map('n', '<C-y>', '3<C-y>', opts("Scroll up"))
map('n', '<C-e>', '3<C-e>', opts("Scroll down"))
map('n', ';', ':', { silent = false })
map('v', ';', ':', { silent = false })
map('n', 'j', 'gj', opts("Faster down"))
map('n', 'k', 'gk', opts("Faster up"))
map('n', '[<space>', ':<c-u>put! =repeat(nr2char(10), v:count1)<cr>', opts("Create line break above"))
map('n', ']<space>', ':<c-u>put =repeat(nr2char(10), v:count1)<cr>', opts("Create line break below"))
map('n', '[e', ':<c-u>execute "move -1-". v:count1<cr>', opts("Move line  above"))
map('n', ']e', ':<c-u>execute "move +". v:count1<cr>', opts("Move line below"))
map("n", "gl", "$", opts("Jump to first available letter"))
map("n", "gh", "^", opts("Jump to last available letter"))


-- Basic Navigation
map('n', '<leader>b', '<cmd>b#<cr>', opts("Previous buffer"))
map('n', '<leader>t', '<cmd>tabnew<cr>', opts("Open new tab"))
map('n', '<leader>w', '<cmd>w!<cr>', opts("Save file"))
map('n', '<leader>q', '<cmd>q!<cr>', opts("Quit"))
map('n', '<leader><space>', '<cmd>nohlsearch<cr>', opts("Disable highlight"))
map('n', '<leader>2', '<cmd>set tabstop=2 shiftwidth=2 softtabstop=2<cr>', opts("Tab 2"))
map('n', '<leader>4', '<cmd>set tabstop=4 shiftwidth=4 softtabstop=4<cr>', opts("Tab 4"))
map('n', '<leader>8', '<cmd>set tabstop=8 shiftwidth=8 softtabstop=8<cr>', opts("Tab 8"))


-- Gitting
map('n', '<leader>gs', '<cmd>Git<cr>', opts("Git status"))
map('n', '<leader>gc', '<cmd>Git commit<cr>', opts("Git commit"))
map('n', '<leader>gn', ':Git checkout -b ', { silent = false, desc = "Create new git branch" })
map('n', '<leader>gg', '<cmd>!ggpull<cr>', opts("Git pull"))
map('n', '<leader>gp', '<cmd>!ggpush<cr>', opts("Git push"))
map('n', '<leader>go', '<cmd>GitLinker<cr>', opts("Git open file in browser"))
map('n', '<leader>gb', function() require('mini.extra').pickers.git_branches() end, opts("Git branches"))
 map('n', '<leader>gd', '<cmd>Gdiff HEAD<cr>', opts("Diff to head"))


-- Visual QoL --
map("v", "<", "<gv", opts("Tab forward"))
map("v", ">", ">gv", opts("Tab backward"))
map("v", ".", ":norm .<cr>", opts("Repeat"))
--map("v", "go", '<cmd>:lua require"gitlinker".get_buf_range_url("v")<cr>', opts)


-- Debugging
map("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts("Toggle Line Break"))
map("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts("Continue"))
map("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts("Step into"))
map("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts("Step over"))
map("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts("Step out"))
map("n", "<leader>d.", "<cmd>lua require'dap'.repl.toggle()<cr>", opts("Repl Toggl"))
map("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts("Run last"))
map("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts("DapUI Toggl"))
map("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts("DapTerminal"))


-- Codeium --
map('i', '<C-f>', function() return vim.fn['codeium#Accept']() end, { expr = true })
map('i', '<c-l>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
map('i', '<c-h>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
map('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })


-- WinMove GOAT
local function win_move(key)
  local curwin = vim.fn.winnr()

  -- try move
  vim.cmd("wincmd " .. key)

  -- if still in same window, create split
  if curwin == vim.fn.winnr() then
    if string.match(key, "[jk]") then
      vim.cmd("wincmd s") -- vertical split
    else
      vim.cmd("wincmd v") -- horizontal split
    end

    -- move again
    vim.cmd("wincmd " .. key)
  end
end

vim.api.nvim_create_user_command("WinMove", function(opts)
  win_move(opts.args)
end, { nargs = 1 })

map("n", "<C-h>", function() win_move("h") end)
map("n", "<C-j>", function() win_move("j") end)
map("n", "<C-k>", function() win_move("k") end)
map("n", "<C-l>", function() win_move("l") end)
