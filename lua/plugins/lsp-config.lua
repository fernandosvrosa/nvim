return {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    config = function()
      require("mason").setup({
        ensure_installed = {
          -- Go
          "gopls",
          -- Java
          "jdtls",
          "java-debug-adapter",
          "vscode-java-test",
          -- Kotlin
          "kotlin-language-server",
          "ktlint",
          -- Clojure
          "clojure-lsp",
          -- TS/JS
          "vtsls",
          -- Lua
          "lua-language-server",
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    config = function()
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        -- Opções padrão para os atalhos
        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- Função auxiliar para facilitar o uso de desc
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
        end

        -- Mapeamentos LSP com descrições
        map("n", "K", vim.lsp.buf.hover, "Mostrar documentação flutuante")
        map("n", "gd", vim.lsp.buf.definition, "Ir para definição")
        map("n", "gD", vim.lsp.buf.declaration, "Ir para declaração")
        map("n", "gi", vim.lsp.buf.implementation, "Ir para implementação")
        map("n", "<leader>gr", vim.lsp.buf.references, "Listar referências")
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Ações de código disponíveis")
      end

      -- Configure gopls
      lspconfig.gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          gopls = {
            ui = {
              semanticTokens = true,
            },
            codelenses = {
              test = true,
            },
            analyses = {
              unusedparams = true,
              shadow = true,
              nilness = true,
              staticcheck = true,
            },
          },
        },
      })

      -- Configure vtsls (TypeScript/JavaScript)
      lspconfig.vtsls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- Configure Kotlin Language Server
      lspconfig.kotlin_language_server.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- Configure Solargraph (Ruby)
      lspconfig.solargraph.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- Configure HTML Language Server
      lspconfig.html.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- Configure Lua Language Server
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- Configure Clojure LSP
      lspconfig.clojure_lsp.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  },
}
