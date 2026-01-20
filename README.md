## Welcome with my nvim config 

If you are unable to search with telescope, run this command to see if you have installed the dependencies it needs on the OS.


```
:checkhealth telescope
```

## Go Development Dependencies

For Go development, you need to install the following tools:

- **gopls (Language Server):**
  ```bash
  go install golang.org/x/tools/gopls@latest
  ```

- **golangci-lint (Linter):**
  ```bash
  go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
  ```

- **delve (Debugger):**
  ```bash
  go install github.com/go-delve/delve/cmd/dlv@latest
  ```

---

## 🧩 Guia de Plugins e Comandos

Abaixo você encontra a explicação do que cada plugin faz na sua configuração e exemplos práticos de uso.

### 🧠 Inteligência de Código (LSP & Autocomplete)

Funcionalidades essenciais para entender o código, autocompletar e formatar.

| Plugin | Para que serve? | Atalhos / Comandos |
| :--- | :--- | :--- |
| **nvim-lspconfig** | Conecta o editor aos servidores de linguagem (Go, Java, Lua, etc) para mostrar erros e definições. | `K` - Mostra documentação (hover)<br>`gd` - Vai para definição<br>`gD` - Vai para declaração<br>`gi` - Vai para implementação<br>`<leader>gr` - Lista referências<br>`<leader>ca` - Ações de código (Code Actions) |
| **nvim-cmp** | Motor de autocompletar (janela flutuante enquanto digita). | `<C-Space>` - Forçar menu de sugestões<br>`<C-e>` - Cancelar sugestão<br>`<Enter>` - Confirmar seleção<br>`<C-b>/<C-f>` - Rolar documentação |
| **none-ls** | Integra formatadores e linters externos (Prettier, Stylua, etc). | `<leader>gf` - Formatar arquivo atual |
| **Copilot** | Sugestões de IA do GitHub Copilot. | *(Texto fantasma automático)*<br>`Tab` geralmente aceita a sugestão. |

### 🛠️ Ferramentas e Navegação

Ferramentas para encontrar arquivos e navegar pelo projeto.

| Plugin | Para que serve? | Atalhos / Comandos |
| :--- | :--- | :--- |
| **Telescope** | Buscador poderoso para tudo. | `<C-p>` - Buscar arquivos por nome<br>`<leader>fg` - Buscar texto dentro dos arquivos (Grep)<br>`<leader>fb` - Buscar buffers abertos |
| **Neo-tree** | Explorador de arquivos lateral (árvore de pastas). | `<leader>e` - Abrir/Fechar explorador |
| **Oil.nvim** | Editor de sistema de arquivos. Edite pastas como se fossem texto! | `-` - Abrir pasta pai (janela flutuante)<br>*(Edite os nomes e salve com :w para renomear/mover)* |
| **Toggleterm** | Gerenciador de terminais integrados. | `<C-\>` - Abrir/Fechar terminal<br>`<leader>rc` - Abrir REPL de Clojure (se configurado) |
| **nvim-dap** | Debugger (igual ao do VS Code). | `<F5>` - Iniciar/Continuar<br>`<F10>` - Passo pular (Step Over)<br>`<F11>` - Passo entrar (Step Into)<br>`<F12>` - Passo sair (Step Out)<br>`<leader>db` - Alternar Breakpoint |

### ⚡ Edição e Produtividade

Melhorias para manipulação de texto e velocidade de codificação.

| Plugin | Para que serve? | Atalhos / Comandos |
| :--- | :--- | :--- |
| **Comment.nvim** | Comentar código rapidamente. | `gcc` - Comentar linha atual<br>`gc` (modo visual) - Comentar seleção<br>`gc3j` - Comentar 3 linhas para baixo |
| **nvim-surround** | Manipular caracteres "ao redor" (aspas, parênteses). | `ysiw"` - Adicionar " ao redor da palavra<br>`ds"` - Deletar " ao redor<br>`cs"'` - Trocar " por ' |
| **vim-visual-multi** | Múltiplos cursores (estilo Sublime/VSCode). | `<C-d>` - Selecionar próxima ocorrência da palavra<br>`<C-Down/Up>` - Adicionar cursores verticalmente |
| **Autopairs** | Fecha parênteses e aspas automaticamente. | *(Automático ao digitar)* |

### 🔧 Linguagens Específicas

Ferramentas sob medida para linguagens específicas.

| Plugin | Para que serve? | Atalhos / Comandos |
| :--- | :--- | :--- |
| **go.nvim** | Canivete suíço para Go. | `<leader>tt` - Rodar testes<br>`<leader>tf` - Rodar função de teste<br>`<leader>tC` - Ver cobertura de testes<br>`<leader>ts` - Adicionar tags struct<br>`<leader>tr` - Remover tags |
| **Conjure** | REPL interativo para Lisps (Clojure, Fennel). Avalia código em tempo real. | `<leader>ee` - Avaliar forma atual<br>`<leader>ef` - Avaliar arquivo inteiro<br>`<leader>er` - Recarregar namespace<br>`<leader>ed` - Ver documentação da palavra sob cursor |

### 🎨 Visual e Interface

Plugins que deixam o editor bonito e informativo.

*   **Alpha:** Tela inicial (Dashboard) com o logo.
*   **Catppuccin:** O tema de cores atual.
*   **Lualine:** Barra de status no rodapé (mostra modo, git branch, erros).
*   **Indent-blankline:** Linhas verticais que mostram a indentação do código.
*   **Which-key:** Menu de ajuda que aparece ao pressionar teclas (ex: pressione `<espaço>` e espere).
*   **Gitsigns:** Mostra alterações do Git na lateral esquerda (linhas adicionadas/removidas).
