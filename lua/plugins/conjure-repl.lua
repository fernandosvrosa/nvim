return {
	{
		"Olical/conjure",
		ft = { "clojure", "fennel", "janet" }, -- ativa só nesses tipos
		init = function()
			vim.g["conjure#mapping#doc_word"] = false -- opcional: desativa atalho 'K'
		end,

		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "clojure",
				callback = function()
					-- Usando vim.keymap.set com descrição (útil com which-key)
					local map = vim.keymap.set
					local opts = { noremap = true, silent = true }

					-- Avaliar a forma atual
					map(
						"n",
						"<leader>ee",
						"<cmd>ConjureEvalCurrentForm<CR>",
						vim.tbl_extend("force", opts, { desc = "Eval: Forma atual" })
					)

					-- Avaliar o buffer inteiro
					map(
						"n",
						"<leader>ef",
						"<cmd>ConjureEvalBuf<CR>",
						vim.tbl_extend("force", opts, { desc = "Eval: Buffer inteiro" })
					)

					-- Recarregar o namespace
					map(
						"n",
						"<leader>er",
						"<cmd>ConjureEvalCurrentForm<CR><cmd>ConjureEval<CR>",
						vim.tbl_extend("force", opts, { desc = "Eval: Reload NS" })
					)

					-- Documentação da forma sob cursor
					map(
						"n",
						"<leader>ed",
						"<cmd>ConjureDocWord<CR>",
						vim.tbl_extend("force", opts, { desc = "Doc: Palavra sob cursor" })
					)
				end,
			})
		end,
	},
	{
		"guns/vim-sexp",
		ft = { "clojure", "fennel", "janet" }, -- ativa só nesses tipos
	},
	{
		"tpope/vim-sexp-mappings-for-regular-people",
		ft = { "clojure", "fennel", "janet" }, -- ativa só nesses tipos
		dependencies = { "guns/vim-sexp" },
	},
	{
		"eraserhd/parinfer-rust",
		build = "cargo build --release",
		ft = { "clojure", "fennel", "janet" },
		config = function()
			vim.g.parinfer_mode = "smart"
		end,
	},
	{
		"tpope/vim-repeat",
		event = "VeryLazy",
	},
	{
		"gpanders/nvim-parinfer",
		ft = { "clojure" },
	},
}
