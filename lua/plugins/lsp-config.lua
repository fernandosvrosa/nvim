return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
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

    require("mason").setup()
    local lspconfig = require "lspconfig"

    require("mason-lspconfig").setup({
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
        "lua_ls",
      },
      handlers = {
        function(server_name)
          local opts = {
            on_attach = on_attach,
            capabilities = capabilities,
          }
          lspconfig[server_name].setup(opts)
        end,
        ["gopls"] = function()
          local opts = {
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
          }
          lspconfig["gopls"].setup(opts)
        end,
      },
    })
  end,
}