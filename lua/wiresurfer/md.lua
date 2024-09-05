local markdown_plugins = {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  },
  { "bullets-vim/bullets.vim", },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true, -- or `opts = {}`
    opts = {
      markdown = {
        headline_highlights = false,

      }
    }
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
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

}

vim.api.nvim_exec([[
function! HandleUrl(url)
 execute "!xdg-open" a:url " &"
endfunction

]], false)

vim.g.mkdp_browserfunc = "HandleUrl"

return markdown_plugins
