return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")

      lspconfig.gopls.setup({
        capabilities = capabilities,
      })

      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.solargraph.setup({
        capabilities = capabilities,
      })
      lspconfig.html.setup({
        capabilities = capabilities,
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.clojure_lsp.setup({
        capabilities = capabilities
      })

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
