return {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    config = function()
      require("mason").setup({
        ensure_installed = {
          -- Go
          "gopls",
          "gofumpt",
          "goimports",
          "golangci-lint",
          -- Java
          "jdtls",
          "java-debug-adapter",
          "vscode-java-test",
          -- Kotlin
          "kotlin-language-server",
          "ktlint",
          -- Clojure
          "clojure-lsp",
          "clj-kondo",
          "zprint",
          -- TS/JS
          "vtsls",
          "prettierd",
          -- Lua
          "lua-language-server",
          "stylua",
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Use the new vim.lsp.config API instead of require('lspconfig')
      -- The new API: access server configs through vim.lsp.config._configs
      -- and configure them using the setup method
      
      -- Configure LSP servers using the new API
      -- Each server configuration is accessed through vim.lsp.config._configs
      local configs = vim.lsp.config._configs
      
      -- Configure gopls
      if configs.gopls then
        configs.gopls.setup({
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
      end

      -- Configure vtsls (TypeScript/JavaScript)
      if configs.vtsls then
        configs.vtsls.setup({
          capabilities = capabilities,
        })
      end

      -- Configure Kotlin Language Server
      if configs.kotlin_language_server then
        configs.kotlin_language_server.setup({
          capabilities = capabilities,
        })
      end

      -- Configure Solargraph (Ruby)
      if configs.solargraph then
        configs.solargraph.setup({
          capabilities = capabilities,
        })
      end

      -- Configure HTML Language Server
      if configs.html then
        configs.html.setup({
          capabilities = capabilities,
        })
      end

      -- Configure Lua Language Server
      if configs.lua_ls then
        configs.lua_ls.setup({
          capabilities = capabilities,
        })
      end

      -- Configure Clojure LSP
      if configs.clojure_lsp then
        configs.clojure_lsp.setup({
          capabilities = capabilities,
        })
      end

      -- Opções padrão para os atalhos
      local opts = { noremap = true, silent = true }

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
    end,
  },
}
