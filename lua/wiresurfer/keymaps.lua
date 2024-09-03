M = {}
local keymap = vim.keymap

function M.whick_remap(chord, cmd, title)
  lvim.builtin.which_key.mappings[chord] = { cmd, title }
end

local allmode = { "n", "v", "i", "c" }
local somemode = { "n", "v", "i", "c" }


keymap.set(allmode, "<C-BS>", "<C-w>")
keymap.set(allmode, "<C-H>", "<C-w>") -- using Ctrl+Backspace delete a word. ref:https://www.reddit.com/r/neovim/comments/prp8zw/using_ctrlbackspace_in_neovim/
keymap.set(somemode, '<Space>za', 'zfat')


keymap.set(somemode, "<Space><tab>", "<cmd>:b#<cr>") -- Switch to previous buffer quickly!
M.whick_remap("LF", "<cmd>LvimToggleFormatOnSave<cr>", "Toggle  Format on Save")
M.whick_remap("LA", "<cmd>ASToggle<cr>", "Toggle  Auto Save")
M.whick_remap("bv", "<C-w>v", "Split vertical")
M.whick_remap("bh", "<C-w>s", "Split Horizonal")
M.whick_remap("bx", ":bd<CR>", "Kill Buffer")

M.whick_remap('mm', '<CMD>MarkdownPreview<CR>', 'Markdown Preview')
M.whick_remap('mo', '<CMD>Outline<CR>', 'Markdown Outline')
M.whick_remap("mp", '<CMD>PasteImage<CR>', 'Markdown Paste Image')

M.whick_remap('lo', '<CMD>Outline<CR>', 'LSP Outline')

M.whick_remap('gn', '<CMD>Neogit<CR>', 'Neogit')

lvim.builtin.which_key.mappings["gO"] = lvim.builtin.which_key.mappings["go"]
lvim.builtin.which_key.mappings["go"] = {
  name = "Git Octo",
  i = {
    name = "Issue",
    l = { "<CMD>Octo issue list", 'List' },
    n = { "<CMD>Octo issue create", 'Create New' },
    c = { "<CMD>Octo issue close", 'Close ' },

  },
  p = {
    name = "PR",
    l = { "<CMD>Octo pr list", 'List' },
    n = { "<CMD>Octo pr create", 'Create New' },
    c = { "<CMD>Octo pr close", 'Close ' },
  },
  r = {
    name = "Review",
    l = { "<CMD>Octo review list", 'List' },
    n = { "<CMD>Octo review create", 'Create New' },
    c = { "<CMD>Octo review close", 'Close ' },
  }
}


lvim.lsp.buffer_mappings.normal_mode['gd'] = nil
lvim.lsp.buffer_mappings.normal_mode['gD'] = nil
lvim.keys.normal_mode['gd'] = "<Cmd>Glance definitions<CR>"
lvim.keys.normal_mode['gD'] = "<cmd>vsplit<CR>lua vim.lsp.buf.declaration()<CR>"
lvim.keys.normal_mode['gR'] = "<cmd>Glance references<CR>"
lvim.keys.normal_mode['gY'] = "<cmd>Glance type_definitions <CR>"
lvim.keys.normal_mode['gM'] = "<cmd>Glance implementations<CR>"
--
-- lvim.lsp.buffer_mappings.normal_mode['gd'] = "<Cmd>Glance definitions<CR>"
-- lvim.lsp.buffer_mappings.normal_mode['gD'] = "<cmd>lua vim.lsp.buf.declaration()<CR>"
-- lvim.lsp.buffer_mappings.normal_mode['gR'] = '<CMD>Glance references<CR>'
-- lvim.lsp.buffer_mappings.normal_mode['gY'] = '<CMD>Glance type_definitions<CR>'
-- lvim.lsp.buffer_mappings.normal_mode['gM'] = '<CMD>Glance implementations<CR>'

keymap.set(allmode, "<C-1>", ":PrtChatToggle vsplit<cr>") -- list current changes per file with diff preview ["gs" for git status]


-- keymap.set(somemode, '<Space>mm', '<CMD>MarkdownPreview<CR>')



return {}
