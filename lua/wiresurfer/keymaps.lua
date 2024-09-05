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
M.whick_remap("bd", ":bd<CR>", "Kill Buffer")

M.whick_remap('mm', '<CMD>MarkdownPreview<CR>', 'Markdown Preview')
M.whick_remap('mo', '<CMD>Outline<CR>', 'Markdown Outline')
M.whick_remap("mp", '<CMD>PasteImage<CR>', 'Markdown Paste Image')

M.whick_remap('lo', '<CMD>Outline<CR>', 'LSP Outline')

M.whick_remap('gn', '<CMD>Neogit<CR>', 'Neogit')
M.whick_remap('gM', '<CMD>Mergetool<CR>', 'Neogit')

M.whick_remap("<space>", "<cmd>Telescope<cr>", "Telescope")
lvim.builtin.which_key.mappings["<space>"] = {
  name = "Telescope",
  p = { '<CMD>Telescope  projects<CR>', 'Projects' },
  f = { '<CMD>Telescope fd<CR>', 'Files' },
  d = { '<CMD>Oil --float ~/Desktop/<CR>', 'Directory' },
  s = { '<CMD>Telescope session-lens<CR>', 'Sessions' },
  b = { '<CMD>Telescope buffers<CR>', 'Buffers' },
}

lvim.builtin.which_key.mappings["gM"] = {
  name = "Mergetool",
  l = { '<CMD>MergetoolPreferLocal<CR>', 'Prefer Local' },
  r = { '<CMD>MergetoolPreferRemote<CR>', 'Prefer Remote' },
  t = { '<CMD>MergetoolToggle<CR>', 'Toggle' },
  s = { '<CMD>MergetoolStart<CR>', 'Start' },
  S = { '<CMD>MergetoolStop<CR>', 'Stop' },
  L = { '<CMD>MergetoolSetLayout<CR>', 'Set Layout' },
  M = { '<CMD>MergetoolToggle<CR>', 'Toggle' },
}

lvim.builtin.which_key.mappings["gO"] = lvim.builtin.which_key.mappings["go"]
lvim.builtin.which_key.mappings["o"] = {
  name = "Git Octo",
  i = {
    name = "Issue",
    l = { "<CMD>Octo issue list<CR>", 'List' },
    n = { "<CMD>Octo issue create<CR>", 'Create New' },
    c = { "<CMD>Octo issue close<CR>", 'Close ' },
    b = { "<CMD>Octo issue browser<CR>", 'Browser ' },
    f = { "<CMD>Octo issue search<CR>", 'Search  ' },
    e = { "<CMD>Octo issue edit<CR>", 'Edit  ' },

  },
  p = {
    name = "PR",
    l = { "<CMD>Octo pr list<CR>", 'List' },
    n = { "<CMD>Octo pr create<CR>", 'Create New' },
    c = { "<CMD>Octo pr close<CR>", 'Close ' },
    r = { "<CMD>Octo pr reopen<CR>", 'Reopen' },
    m = { "<CMD>Octo pr merge<CR>", 'Merge ' },
    d = { "<CMD>Octo pr diff<CR>", 'Diff ' },
    s = { "<CMD>Octo pr search<CR>", 'Search' },

  },
  r = {
    name = "Review",
    l = { "<CMD>Octo review list<CR>", 'List' },
    n = { "<CMD>Octo review create<CR>", 'Create New' },
    c = { "<CMD>Octo review close<CR>", 'Close ' },
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
