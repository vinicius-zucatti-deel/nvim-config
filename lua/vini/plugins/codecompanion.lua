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
      chat = { adapter = "llama3" },
      inline = { adapter = "llama3" },
    },
    adapters = {
      llama3 = function()
        return require("codecompanion.adapters").extend("ollama", {
          name = "llama3",
          schema = {
            model = {
              default = "llama3",
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
    },
    display = {
      diff = {
        enabled = true,
        close_chat_at = 240,
        layout = "vertical",
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
