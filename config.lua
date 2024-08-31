-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. ".luarocks/share/lua/5.1/magick/init.lua"

local keymap = vim.keymap
function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

lvim.plugins = {
  { 'dnlhc/glance.nvim' },
  { "bullets-vim/bullets.vim", },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>O", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {

    }
  },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true, -- or `opts = {}`
  },
  {
    "3rd/image.nvim",
    event = "VeryLazy",
    dependencies = {
      "leafo/magick",
      {
        "vhyrro/luarocks.nvim",
        opts = {
          rocks = {
            hererocks = true,
          },
        },
      },
      {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
          require("nvim-treesitter.configs").setup({
            ensure_installed = { "markdown" },
            highlight = { enable = true },
          })
        end,
      },
    },
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = true,
          filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
        },
        html = {
          enabled = true,
        },
        css = {
          enabled = true,
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      kitty_method = "normal",
      window_overlap_clear_enabled = false,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      editor_only_render_when_focused = true,
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
    },
  },
  {
    "prettier/vim-prettier",
    -- File types to enable vim-prettier for
    ft = {
      "markdown",
    },
    init = function()
      -- The following two options can be used together for autoformatting files
      -- on save without @format or @prettier tags
      vim.g["prettier#autoformat"] = 1
      vim.g["prettier#autoformat_require_pragma"] = 0
      -- Set prose_wrap to always, never, or preserve
      -- "always" is what enables auto wrapping
      vim.g["prettier#config#prose_wrap"] = "always"
    end,
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      default = {
        dir_path = "Assets",
        use_absolute_path = false,
        relative_to_current_file = true,
        extensions = "png",
        process_cmd =
        "convert - -depth 24 -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 png:-",


      },
      -- add options here
      -- or leave it empty to use the default settings
      filetypes = {
        markdown = {
          url_encode_path = true, ---@type boolean
          template = "![$CURSOR]($FILE_PATH)", ---@type string
          download_images = true, ---@type boolean
        },
      },
    },
    keys = {
      -- suggested keymap
      { "<leader>mp", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
  {
    "frankroeder/parrot.nvim",
    tag = "v0.3.9",
    dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim' },
    -- optionally include "rcarriga/nvim-notify" for beautiful notifications
    config = function()
      require("parrot").setup {
        -- Providers must be explicitly added to make them available.
        providers = {
          pplx = {
            api_key = os.getenv "PERPLEXITY_API_KEY",
            -- OPTIONAL
            -- gpg command
            -- api_key = { "gpg", "--decrypt", vim.fn.expand("$HOME") .. "/pplx_api_key.txt.gpg"  },
            -- macOS security tool
            -- api_key = { "/usr/bin/security", "find-generic-password", "-s pplx-api-key", "-w" },
          },
          openai = {
            api_key = os.getenv "OPENAI_API_KEY",
          },
          anthropic = {
            api_key = os.getenv "ANTHROPIC_API_KEY",
          },
          mistral = {
            api_key = os.getenv "MISTRAL_API_KEY",
          },
          gemini = {
            api_key = os.getenv "GEMINI_API_KEY",
          },
          ollama = {} -- provide an empty list to make provider available
        },
      }
    end,
    hooks = {
      CompleteFullContext = function(prt, params)
        local template = [[
          I have the following code from {{filename}}:

          ```{{filetype}}
          {{filecontent}}
          ```

          Please look at the following section specifically:
          ```{{filetype}}
          {{selection}}
          ```

          Please finish the code above carefully and logically.
          Respond just with the snippet of code that should be inserted.
          ]]
        local agent = prt.get_command_agent()
        prt.Prompt(params, prt.ui.Target.append, agent, nil, template)
      end,
    }
  }
}

local allmode = { "n", "v", "i", "c" }
keymap.set(allmode, "<C-BS>", "<C-w>")
keymap.set(allmode, "<C-H>", "<C-w>") -- using Ctrl+Backspace delete a word. ref:https://www.reddit.com/r/neovim/comments/prp8zw/using_ctrlbackspace_in_neovim/

keymap.set("n", "<Space>sv", "<C-w>v")
keymap.set("n", "<Space>sh", "<C-w>s")
keymap.set("n", "<Spave>sx", ":bd<CR>")

keymap.set("n", "<Space><tab>", "<cmd>:b#<cr>") -- list current changes per file with diff preview ["gs" for git status]

lvim.lsp.buffer_mappings.normal_mode['gd'] = nil
lvim.lsp.buffer_mappings.normal_mode['gD'] = nil
lvim.keys.normal_mode['gd'] = "<Cmd>Glance definitions<CR>"
lvim.keys.normal_mode['gD'] = "<cmd>lua vim.lsp.buf.declaration()<CR>"
-- keymap.set('n', 'gD', '<CMD>Glance definitions<CR>')
keymap.set('n', 'gR', '<CMD>Glance references<CR>')
keymap.set('n', 'gY', '<CMD>Glance type_definitions<CR>')
keymap.set('n', 'gM', '<CMD>Glance implementations<CR>')

-- keymap.set(allmode, "<M-\\>", ":ToggleTerm direction=float<cr>") -- list current changes per file with diff preview ["gs" for git status]
keymap.set(allmode, "<C-1>", ":PrtChatToggle vsplit<cr>") -- list current changes per file with diff preview ["gs" for git status]
-- keymap.set(allmode, "<C-`>", ":ToggleTerm direction=float<cr>") -- list current changes per file with diff preview ["gs" for git status]
lvim.builtin.terminal.open_mapping = "<c-`>"


keymap.set({ "n", "c", "v" }, '<Space>mm', '<CMD>MarkdownPreview<CR>')
keymap.set({ "n", "c", "v" }, '<Space>mp', '<CMD>PasteImage<CR>')
keymap.set({ "n", "c", "v" }, '<Space>mo', '<CMD>Outline<CR>')


keymap.set('n', '<Space>za', 'zfat')

lvim.builtin.nvimtree.setup.update_focused_file.update_root = false
