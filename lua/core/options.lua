vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.g.mapleader = " "

vim.opt.swapfile = false

-- Cores true-color (necessário para o catppuccin renderizar corretamente)
vim.opt.termguicolors = true

-- Qualidade de vida
vim.opt.signcolumn = "yes"   -- evita o texto "pulando" com gitsigns/diagnósticos
vim.opt.scrolloff = 8        -- mantém contexto ao rolar
vim.opt.ignorecase = true
vim.opt.smartcase = true     -- busca sensível a maiúsculas só quando há maiúsculas
vim.opt.undofile = true      -- undo persistente entre sessões
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true
vim.opt.updatetime = 250     -- mais responsivo (default 4000ms; afeta autoread no CursorHold)

-- Recarrega automaticamente arquivos editados fora do Neovim
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

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
