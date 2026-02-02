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

-- Mapeamento manual de segurança para LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Goto References" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
-- Ir para a implementação (útil para Interfaces e Traits)
vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
-- Ir para a definição do Tipo (ex: se o cursor está numa variável, vai para a Struct/Classe dela)
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { desc = "Goto T[y]pe Definition" })
-- Ir para a Declaração (menos usado que gd, mas útil em C/C++ ou headers)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })

-- Renomear símbolo (o LazyVim costuma usar <leader>cr)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })

-- Ações de código (Lâmpada do VS Code)
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

-- Ações de código (Lâmpada do VS Code)
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

-- Pular para o próximo erro/aviso
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })

-- Pular para o erro anterior
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })

-- Abrir o erro atual em uma janelinha flutuante (Floating Window)
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
