local ux_plugins = {
  {
    "pocco81/auto-save.nvim",
    enabled = false,
    opts = {
      debounce_delay = 30000,
    }
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
      })
    end
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

}

lvim.builtin.nvimtree.setup.update_focused_file.update_root = false

lvim.builtin.telescope.pickers.find_files = {
  layout_strategy = "horizontal",
  layout_config = { width = 0.85, height = 0.80, preview_width = 0.5, preview_cutoff = 120, prompt_position = "top" }
}

lvim.builtin.telescope.pickers.live_grep = {
  layout_config = { height = 0.90, width = 0.90, preview_cutoff = 120, preview_width = 0.6, prompt_position = "top" },
  layout_strategy = "horizontal"
}

lvim.builtin.telescope.pickers.git_commits = {
  layout_strategy = "horizontal",
  layout_config = { height = 0.88, width = 0.88, preview_cutoff = 20, preview_width = 0.70, prompt_position = "bottom" }
}

lvim.builtin.telescope.pickers.man_pages = {
  layout_strategy = "horizontal",
  layout_config = { height = 0.99, width = 0.99, preview_cutoff = nil, preview_width = 0.80, prompt_position = "bottom" }
}

lvim.builtin.telescope.pickers.vim_options = { layout_config = { height = 0.75, width = 0.75 } }


return ux_plugins
