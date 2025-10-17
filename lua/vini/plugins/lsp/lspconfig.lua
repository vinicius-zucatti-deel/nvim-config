return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local keymap = vim.keymap
    local lsp = vim.lsp
    local bufopts = { noremap = true, silent = true }

    -- LspAttach keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", lsp.buf.declaration, opts)

        -- 0.11 built-ins
        keymap.set("n", "gr", lsp.buf.references, bufopts)
        keymap.set("n", "gd", lsp.buf.definition, bufopts)

        keymap.set("n", "gy", lsp.buf.type_definition, { desc = "Go to Type Definition" })

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Hover docs"
        keymap.set("n", "K", lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    -- completion capabilities
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Base memory limit for Node-based LSPs
    local NODE_MAX_MEM = "16384" -- 16 GB

    -- Common Node-based servers to patch
    local node_servers = { "vtsls", "tsserver", "eslint", "pyright", "tailwindcss" }

    for _, server in ipairs(node_servers) do
      if vim.fn.exepath(server) ~= "" then
        vim.lsp.config(server, {
          capabilities = capabilities,
          cmd = {
            "node",
            "--max-old-space-size=" .. NODE_MAX_MEM,
            vim.fn.exepath(server),
            "--stdio",
          },
        })
      end
    end

    -- vtsls configuration (TypeScript)
    vim.lsp.config("vtsls", {
      capabilities = capabilities,
      root_markers = { "tsconfig.json", "package.json", ".git" },
      settings = {
        typescript = { tsserver = { maxTsServerMemory = tonumber(NODE_MAX_MEM) } },
        vtsls = {
          enableMoveToFileCodeAction = true,
          experimental = { completion = { enableServerSideFuzzyMatch = true } },
        },
      },
    })

    -- enable servers
    vim.lsp.enable("vtsls")
    -- vim.lsp.enable({ "lua_ls", "astro", "graphql" })

    -- diagnostic signs
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
  end,
}
