return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
        "recent", -- optional custom source
      },
      window = {
        position = "left",
        width = 35,
        number = true,
        relativenumber = true,
      },
      filesystem = {
        bind_to_cwd = true, -- keep in sync with vim's current working directory
        follow_current_file = {
          enabled = true, -- Follow the currently active buffer
          leave_dirs_open = false, -- Optional: close other expanded dirs
        },
      },
    })

    vim.keymap.set("n", "<leader>e", ":Neotree toggle left<CR>", { desc = "Toggle file tree" })
    vim.keymap.set("n", "<leader>r", ":Neotree reveal<CR>", { desc = "Reveal current file in tree" })
  end,
}
