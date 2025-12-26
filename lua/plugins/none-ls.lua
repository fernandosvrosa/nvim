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
        "rubocop",
      },
      automatic_installation = true,
      handlers = {},
    })

    null_ls.setup({
      sources = {}, -- mason-null-ls handles all the sources
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
