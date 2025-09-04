vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.g.background = "light"

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
-- vim.wo.number = true

-- Ativa a numeração de linha
vim.opt.nu = true

-- Ativa a numeração de linha relativa
vim.opt.rnu = true

vim.g["sexp_filetypes"] = "clojure,fennel,janet"

-- Conjure leader
vim.g.maplocalleader = ","


if string.find(vim.fn.system("uname -r"), "WSL") then
	vim.opt.clipboard = "unnamedplus"
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = "powershell.exe -c Get-Clipboard",
			["*"] = "powershell.exe -c Get-Clipboard",
		},
	}
end
