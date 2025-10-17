return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    -- local open_with_trouble = require("trouble.sources.telescope").open

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        -- layout_strategy = "vertical",
        -- layout_config = { width = 0.5 },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            -- ["<C-t>"] = open_with_trouble,
          },
          -- n = {
          --   ["<C-t>"] = open_with_trouble,
          -- },
        },
      },
    })
    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    --
    -- keymap.set("n", "<leader>p", "<cmd>Telescope git_files<cr>", { desc = "Fuzzy find files in git files" })
    -- -- keymap.set("n", "<leader>p", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    -- keymap.set("n", "<leader>P", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy find buffers files" })
    --
    -- keymap.set("n", "<leader>f", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    --
    -- keymap.set("n", "<leader>Fgs", "<cmd>Telescope git_status<cr>", { desc = "Find git unstashed files" })
    -- keymap.set("n", "<leader>Fgc", "<cmd>Telescope git_commits<cr>", { desc = "Find git commits" })
    -- keymap.set("n", "<leader>Ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    -- keymap.set("n", "<leader>Fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    -- keymap.set("n", "<leader>Fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    keymap.set("n", "<leader>fy", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Find symbols" })
    keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Find marks" })
    -- keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Find diagnostics" })
  end,
}
