return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- LspAttach funciona com automatic_enable (Neovim 0.11+)
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
        end

        -- Navegação LSP
        map("n", "K",           vim.lsp.buf.hover,           "Hover Documentation")
        map("n", "gd",          vim.lsp.buf.definition,      "Goto Definition")
        map("n", "gD",          vim.lsp.buf.declaration,     "Goto Declaration")
        map("n", "gi",          vim.lsp.buf.implementation,  "Goto Implementation")
        map("n", "gy",          vim.lsp.buf.type_definition, "Goto T[y]pe Definition")
        map("n", "gr",          vim.lsp.buf.references,      "Goto References")

        -- Ações
        map("n",         "<leader>rn", vim.lsp.buf.rename,      "Rename Symbol")
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n",         "<leader>gf", vim.lsp.buf.format,      "Format Buffer")

        -- Diagnósticos
        map("n", "]d",         vim.diagnostic.goto_next,  "Next Diagnostic")
        map("n", "[d",         vim.diagnostic.goto_prev,  "Prev Diagnostic")
        map("n", "<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")
      end,
    })

    require("mason").setup()
    local lspconfig = require "lspconfig"

    require("mason-lspconfig").setup({
      -- Evita que mason-lspconfig ative automaticamente pacotes Mason
      -- que são formatters (ex: stylua), conflitando com none-ls
      automatic_enable = {
        exclude = { "stylua" },
      },
      ensure_installed = {
        -- Go
        "gopls",
        -- Java
        "jdtls",
        -- Kotlin
        "kotlin_language_server",
        -- Clojure
        "clojure_lsp",
        -- TS/JS
        "vtsls",
        -- Elixir
        "elixirls",
        -- Lua
        "lua_ls",
      },
      handlers = {
        function(server_name)
          local opts = {
            capabilities = capabilities,
          }
          lspconfig[server_name].setup(opts)
        end,
        ["gopls"] = function()
          local opts = {
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