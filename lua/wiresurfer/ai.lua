local ai_tools = {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",    -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    "frankroeder/parrot.nvim",
    tag = "v0.3.9",
    enabled = false,
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
return ai_tools
