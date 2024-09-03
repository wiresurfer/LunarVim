local dev_helper_plugins = {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python",
      'theHamsta/nvim-dap-virtual-text',
      "rcarriga/cmp-dap",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      { "<leader>du", function() require("dapui").toggle({}) end,                                           desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end,                                               desc = "Eval",                   mode = { "n", "v" } },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>db", ":DapToggleBreakpoint<cr>",                                                           desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
      { "<F5>",       function() require("dap").step_into() end,                                            desc = "Step Into" },
      { "<F6>",       function() require("dap").step_over() end,                                            desc = "Step Over" },
      { "<F7>",       function() require("dap").step_out() end,                                             desc = "Step Out" },
      { "<F8>",       "!debugpy --listen 9099 --wait-for-client %",                                         desc = "Debug" },
      { "<leader>d.", "!debugpy --listen 5678 --wait-for-client % & <cr>",                                  desc = "Debug" },
      { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
      { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("dap-python").setup("python3")
      require("nvim-dap-virtual-text").setup()

      local hide_info = function()
        print("hide")
        vim.diagnostic.disable()
        vim.api.nvim_command(":Gitsigns toggle_current_line_blame")
      end

      local show_info = function()
        vim.diagnostic.enable()
        vim.api.nvim_command(":Gitsigns toggle_current_line_blame")
      end

      dap.listeners.after.event_initialized["dapui_config"] = function()
        hide_info()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        show_info()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        show_info()
        dapui.close({})
      end

      dapui.setup({
        layouts = {
          {
            elements = {
              {
                id = "stacks",
                size = 0.5
              },
              {
                id = "breakpoints",
                size = 0.25
              },
            },
            position = "left",
            size = 40
          },
          {
            elements = {
              {
                id = "repl",
                size = 0.5
              },
              {
                id = "scopes",
                size = 0.5
              },
            },
            position = "bottom",
            size = 20
          }
        },
      })
      dap.set_log_level("TRACE")

      local pythonAttachConfig = {
        type = "python",
        request = "attach",
        connect = {
          port = 5678,
          host = "0.0.0.0",
        },
        mode = "remote",
        name = "Container Attach (with choose remote dir)",
        cwd = vim.fn.getcwd(),
        pathMappings = {
          {
            localRoot = vim.fn.getcwd(),
            remoteRoot = function()
              -- NEED to choose correct folder for set breakpoints
              return vim.fn.input("Container code folder > ", ".", "file")
            end,
          },
        },
      }
      table.insert(require("dap").configurations.python, pythonAttachConfig)

      -- change Breakpoint icon
      vim.fn.sign_define("DapBreakpoint", {
        text = "🅑 ",
        texthl = "",
        linehl = "",
        numhl = ""
      }
      )

      -- setup dap autocomplition
      require("cmp").setup({
        enabled = function()
          return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
              or require("cmp_dap").is_dap_buffer()
        end
      })

      require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
        },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>lx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>ltX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>lts",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>ltl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>ltL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>ltQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  { 'dnlhc/glance.nvim' },
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
}
return dev_helper_plugins
