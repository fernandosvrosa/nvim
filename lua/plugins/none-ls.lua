return {
  "nvimtools/none-ls.nvim",
  event = "VeryLazy",
  dependencies = {
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local mason_null_ls = require("mason-null-ls")

    mason_null_ls.setup({
      -- A list of formatters & linters to be installed with mason-null-ls
      ensure_installed = {
        -- Lua
        "stylua",
        -- JS/TS
        "prettierd",
        -- Go
        "goimports",
        "gofumpt",
        "golangci-lint",
        -- Clojure
        "clj-kondo",
        "zprint",
        -- Ruby
        --"rubocop",
      },
      automatic_installation = true,
      handlers = {},
    })

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      sources = {
        -- Elixir: mix format é parte do toolchain, não um pacote Mason
        null_ls.builtins.formatting.mix,
      },
      -- Formata ao salvar usando os formatters do none-ls
      on_attach = function(client, bufnr)
        if client:supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                bufnr = bufnr,
                -- prefere os formatters do none-ls (evita dupla formatação com o LSP)
                filter = function(c)
                  return c.name == "null-ls"
                end,
              })
            end,
          })
        end
      end,
    })

  end,
}
