local ai_tools = {
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
return ai_tools
