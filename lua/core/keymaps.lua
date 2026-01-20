-- Defina seus atalhos de teclado aqui

local map = vim.keymap.set

-- Melhor navegação entre janelas (splits)
map("n", "<C-h>", "<C-w>h", { desc = "Navegar para esquerda" })
map("n", "<C-j>", "<C-w>j", { desc = "Navegar para baixo" })
map("n", "<C-k>", "<C-w>k", { desc = "Navegar para cima" })
map("n", "<C-l>", "<C-w>l", { desc = "Navegar para direita" })

-- Redimensionar janelas com as setas
map("n", "<Up>", ":resize +2<CR>", { desc = "Aumentar altura" })
map("n", "<Down>", ":resize -2<CR>", { desc = "Diminuir altura" })
map("n", "<Left>", ":vertical resize -2<CR>", { desc = "Diminuir largura" })
map("n", "<Right>", ":vertical resize +2<CR>", { desc = "Aumentar largura" })

-- Mover texto selecionado no modo Visual
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Mover texto para baixo" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Mover texto para cima" })

-- Manter indentação no modo Visual
map("v", "<", "<gv", { desc = "Diminuir indentação" })
map("v", ">", ">gv", { desc = "Aumentar indentação" })

-- Limpar busca com Esc
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Limpar destaque da busca" })

-- Salvar e Sair facilitados
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Salvar arquivo" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Sair" })
map("n", "<leader>Q", "<cmd>qa<CR>", { desc = "Sair de tudo" })
