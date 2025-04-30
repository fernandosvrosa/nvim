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

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {}) --ver a documentação
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {}) -- Ir para definição
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {}) -- ir para referencia
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {}) -- code action
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {}) -- Ir para declaração
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {}) -- Ações de código
		end,
	},
}
