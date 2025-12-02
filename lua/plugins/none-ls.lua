return {
	"nvimtools/none-ls.nvim",
    event = "VeryLazy",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- Lua
				null_ls.builtins.formatting.stylua,
				-- JS/TS
				null_ls.builtins.formatting.prettierd,
				-- Go
				null_ls.builtins.formatting.goimports,
				null_ls.builtins.formatting.gofumpt,
				null_ls.builtins.diagnostics.golangci_lint,
				-- Clojure
				null_ls.builtins.diagnostics.clj_kondo,
				null_ls.builtins.formatting.zprint,
				-- Ruby
				null_ls.builtins.diagnostics.rubocop,
				null_ls.builtins.formatting.rubocop,
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
