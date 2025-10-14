return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import mason_lspconfig plugin
    local mason_lspconfig = require("mason-lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness
    local lsp = vim.lsp
    local bufopts = { noremap = true, silent = true }

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        -- opts.desc = "Show LSP definitions"
        -- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
        --
        -- opts.desc = "Show LSP implementations"
        -- keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations
        --
        -- opts.desc = "Show LSP type definitions"
        -- keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        -- NVIM 0.11 Config
        keymap.set("n", "gr", lsp.buf.references, bufopts)
        keymap.set("n", "gd", lsp.buf.definition, bufopts)
        -- NVIM 0.11 Config

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()
    lspconfig.vtsls.setup({
      capabilities = capabilities,
      root_dir = require("lspconfig.util").root_pattern("tsconfig.json", "package.json", ".git"),
      settings = {
        typescript = {
          tsserver = {
            maxTsServerMemory = 8192,
          },
        },
        vtsls = {
          enableMoveToFileCodeAction = true,
          experimental = {
            completion = {
              enableServerSideFuzzyMatch = true,
            },
          },
        },
      },
    })

    local function eslint_root_dir(fname)
      -- 1) Standard flat config or classic .eslintrc in any ancestor
      local root = util.root_pattern(
        "eslint.config.js",
        "eslint.config.cjs",
        "eslint.config.mjs",
        "eslint.config.ts",
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.json",
        ".eslintrc.yaml",
        ".eslintrc.yml"
      )(fname)
      if root then
        return root
      end

      -- 2) app/eslint.config.* living under a higher project root
      local app_root = util.search_ancestors(fname, function(path)
        local app = util.path.join(path, "app")
        local candidates = {
          "eslint.config.js",
          "eslint.config.cjs",
          "eslint.config.mjs",
          "eslint.config.ts",
        }
        for _, f in ipairs(candidates) do
          if util.path.is_file(util.path.join(app, f)) then
            return app
          end
        end
      end)
      if app_root then
        return app_root
      end

      -- 3) Fallback to package.json/.git
      return util.root_pattern("package.json", ".git")(fname)
    end

    lspconfig.eslint.setup({
      capabilities = capabilities,
      root_dir = eslint_root_dir,
      settings = {
        -- Show/fix issues while typing and on save
        run = "onType",
        format = true,
        codeAction = {
          disableRuleComment = { enable = true, location = "separateLine" },
          showDocumentation = { enable = true },
        },
        codeActionOnSave = { enable = true, mode = "all" }, -- enables EslintFixAll
        workingDirectory = { mode = "auto" }, -- respects eslint's cwd logic
        experimental = { useFlatConfig = true }, -- safe even if using legacy; ignored there
        validate = "on",
      },
      on_attach = function(client, bufnr)
        -- Optional: ensure fixes run before write
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
    })

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- mason_lspconfig.setup_handlers({
    --   -- default handler for installed servers
    --   function(server_name)
    --     lspconfig[server_name].setup({
    --       capabilities = capabilities,
    --     })
    --   end,
    --   ["graphql"] = function()
    --     -- configure graphql language server
    --     lspconfig["graphql"].setup({
    --       capabilities = capabilities,
    --       filetypes = { "graphql", "gql", "astro", "typescriptreact", "javascriptreact" },
    --     })
    --   end,
    --   ["astro"] = function()
    --     -- configure astro server
    --     lspconfig["astro"].setup({
    --       capabilities = capabilities,
    --       on_attach = function(client, bufnr)
    --         vim.api.nvim_create_autocmd("BufWritePost", {
    --           pattern = { "*.js", "*.ts" },
    --           callback = function(ctx)
    --             -- Here use ctx.match instead of ctx.file
    --             client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
    --           end,
    --         })
    --       end,
    --     })
    --   end,
    --   ["lua_ls"] = function()
    --     -- configure lua server (with special settings)
    --     lspconfig["lua_ls"].setup({
    --       capabilities = capabilities,
    --       settings = {
    --         Lua = {
    --           -- make the language server recognize "vim" global
    --           diagnostics = {
    --             globals = { "vim" },
    --           },
    --           completion = {
    --             callSnippet = "Replace",
    --           },
    --         },
    --       },
    --     })
    --   end,
    -- })
  end,
}
