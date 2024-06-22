return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  -- dependencies = {
  --   "windwp/nvim-ts-autotag",
  -- },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
    treesitter.setup({
      modules = {},
      auto_install = true,
      sync_install = false,
      ignore_install = { "php" },
      -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      -- autotag = {
      --   enable_close = true, -- Auto close tags
      --   enable_rename = true, -- Auto rename pairs of tags
      --   enable_close_on_slash = false, -- Auto close on trailing </
      --   enable = true,
      --   -- filetypes = {
      --   --   "html",
      --   --   "javascript",
      --   --   "typescript",
      --   --   "javascriptreact",
      --   --   "typescriptreact",
      --   --   "svelte",
      --   --   "vue",
      --   --   "tsx",
      --   --   "jsx",
      --   --   "rescript",
      --   --   "css",
      --   --   "lua",
      --   --   "xml",
      --   --   "php",
      --   --   "markdown",
      --   -- },
      -- },
      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "astro",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "rust",
        "ruby",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
