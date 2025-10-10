return {
  "olimorris/codecompanion.nvim",
  version = "11.17.5",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    log_level = "DEBUG",
    strategies = {
      chat = { adapter = "openai" },
      inline = { adapter = "openai" },
    },
    adapters = {
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          name = "codellama:7b-code",
          schema = {
            model = {
              default = "codellama:7b-code",
            },
          },
          env = {
            url = "http://127.0.0.1:11434",
          },
          parameters = {
            sync = true,
          },
        })
      end,
      openai = function()
        return require("codecompanion.adapters").extend("openai", {
          env = {
            api_key = vim.fn.getenv("OPENAI_API_KEY"),
          },
        })
      end,
    },
    display = {
      diff = {
        enabled = true,
        close_chat_at = 240,
        layout = "vertical",
        position = "right",
        opts = {
          "internal",
          "filler",
          "closeoff",
          "algorithm:patience",
          "followwrap",
          "linematch:120",
        },
        provider = "default",
      },
    },
  },
}
