return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.diagnostics.rubocop,
				null_ls.builtins.formatting.rubocop,
				null_ls.builtins.formatting.prettier,
				-- Formatador: goimports (formata e organiza imports)
				null_ls.builtins.formatting.goimports,
				-- Linter: revive (análise estática mais moderna que golint)
				null_ls.builtins.diagnostics.revive,
				-- Linter para Clojure
				null_ls.builtins.diagnostics.clj_kondo,
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
