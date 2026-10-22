# Neovim Config — Contexto para Claude

## Estrutura

```
~/.config/nvim/
├── init.lua                  # Entry point: carrega options, keymaps e lazy
├── lua/
│   ├── core/
│   │   ├── options.lua       # Opções do Neovim (tabs, numbers, clipboard WSL)
│   │   └── keymaps.lua       # Keymaps globais (navegação, LSP, diagnósticos)
│   └── plugins/              # Um arquivo por plugin (carregados pelo lazy.nvim)
│       ├── lsp-config.lua    # nvim-lspconfig + mason + mason-lspconfig
│       ├── completions.lua   # nvim-cmp + LuaSnip + friendly-snippets
│       ├── treesitter.lua    # nvim-treesitter
│       ├── telescope.lua     # telescope + telescope-ui-select + telescope-fzf-native
│       ├── none-ls.lua       # none-ls (null-ls) + mason-null-ls (formatters/linters) + format-on-save
│       ├── debbuging.lua     # nvim-dap + dapui + dap-go + dap-vscode-js
│       ├── gitsigns.lua      # gitsigns (hunks, blame, diff)
│       ├── neo-tree.lua      # neo-tree (file explorer)
│       ├── lualine.lua       # lualine (statusline)
│       ├── which-key.lua     # which-key (popup de atalhos)
│       ├── toggleterm.lua    # toggleterm + REPL Clojure (clj) + Claude Code CLI
│       ├── conjure-repl.lua  # conjure + vim-sexp + parinfer-rust (Clojure/Fennel/Janet)
│       ├── catppuccin.lua    # colorscheme catppuccin (tema principal)
│       ├── copilot.lua       # github copilot
│       ├── hurl.lua          # hurl.nvim: cliente HTTP para arquivos .hurl (requer binário `hurl` + `jq`)
│       ├── markdown.lua      # render-markdown (render no buffer) + live-preview (preview no navegador)
│       ├── go.lua            # go.nvim (GoTest, GoCoverage, AddTags)
│       ├── oil.lua           # oil.nvim
│       ├── autopairs.lua     # nvim-autopairs
│       ├── surround.lua      # nvim-surround
│       ├── comment.lua       # Comment.nvim
│       ├── indent-blankline.lua  # indent-blankline
│       ├── vim-visual-multi.lua  # multi-cursor
│       └── alpha.lua         # dashboard de início
```

## Plugin Manager

**lazy.nvim** — configurado em `init.lua`, carrega todos os arquivos em `lua/plugins/`.
- `lua/plugins.lua` existe mas está vazio (`return {}`); os plugins ficam nos arquivos individuais.

## Linguagens configuradas

| Linguagem   | LSP                  | Formatter/Linter               | Extras                          |
|-------------|----------------------|--------------------------------|---------------------------------|
| Go          | gopls                | goimports, gofumpt, golangci-lint | go.nvim, nvim-dap-go         |
| Java        | jdtls                | —                              | —                               |
| Kotlin      | kotlin_language_server | —                            | —                               |
| Clojure     | clojure_lsp          | clj-kondo, zprint              | conjure, vim-sexp, parinfer-rust |
| Elixir      | elixirls             | mix format (builtin)           | —                               |
| TypeScript  | vtsls                | prettierd                      | nvim-dap-vscode-js              |
| JavaScript  | vtsls                | prettierd                      | nvim-dap-vscode-js              |
| Lua         | lua_ls               | stylua                         | —                               |

## Colorscheme

**catppuccin** (tema único, priority 1000, lazy=false).
- Lualine também usa tema `catppuccin`.
- Não instalar/referenciar outros temas (ex: dracula não está instalado).

## Keymaps principais

- `<leader>` = `<Space>`
- `<localleader>` = `,` (usado pelo Conjure)
- `<C-h/j/k/l>` — navegação entre splits (definidos **apenas** em `keymaps.lua`)
- `<C-p>` — Telescope find files
- `<leader>fg` — Telescope live grep
- `<leader>fb` — Telescope buffers
- `<leader>e` — NeoTree toggle
- `<leader>gf` — format (LSP)
- `<leader>w/q/Q` — salvar/sair
- `<leader>ca` — code action
- `<leader>rn` — rename symbol
- `<leader>db` — DAP toggle breakpoint
- `<leader>rr/ra/re/rs/rl/rt/rv/rm` — Hurl HTTP (só em buffers .hurl)
- `<leader>mr/mp/ms/mf` — Markdown: toggle render / iniciar preview / parar preview / escolher arquivo
- `<leader>ai` — Claude Code CLI (toggleterm float)
- `<leader>rc` — Clojure REPL (toggleterm)
- `<leader>ee/ef/er/ed` — Conjure eval (só em buffers Clojure)
- `<F5/10/11/12>` — DAP continue/step over/into/out

## Convenções

- Keymaps **globais** ficam em `core/keymaps.lua`.
- Keymaps **buffer-local LSP** ficam no `on_attach` em `lsp-config.lua`.
- Keymaps de **plugin específico** ficam no `config` do próprio plugin.
- Todos os keymaps devem ter `desc = "..."` para funcionar bem com which-key.
- Usar **referências a funções** nos keymaps, não strings `:lua ...`.
- Indentação: **2 espaços** (expandtab, tabstop=2).

## Notas importantes

- `mason-lspconfig.ensure_installed` aceita **nomes do lspconfig** (underscores): `kotlin_language_server`, `clojure_lsp`, `elixirls`, etc. Adapters DAP (`java-debug-adapter`, `vscode-java-test`) e linters (`ktlint`) **não** devem estar aqui.
- Linters/formatters ficam em `mason-null-ls.ensure_installed` (em `none-ls.lua`). Formatters que fazem parte do toolchain da linguagem (ex: `mix format` do Elixir) devem ser adicionados como `sources` explícitos no `null_ls.setup`, não via Mason.
- **Format-on-save**: configurado em `none-ls.lua` via `on_attach` do null-ls (autocmd `BufWritePre`, augroup `LspFormatting`). O `vim.lsp.buf.format` usa `filter` para rodar **apenas** os formatters do none-ls (`c.name == "null-ls"`), evitando dupla formatação com o LSP da linguagem (ex: gopls). Formatação manual também disponível em `<leader>gf` (LSP).
- **Telescope**: usa `telescope-fzf-native` (compilado via `make`, requer toolchain C) para busca fuzzy rápida. Setup, extensões (`ui-select`, `fzf`) e keymaps ficam todos no mesmo bloco em `telescope.lua`.
- Parinfer: `parinfer-rust` está comentado em `conjure-repl.lua` pois requer `cargo` (Rust) para compilar. Para ativar, instalar Rust (`curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`) e descomentar a linha.
- **Treesitter**: usa o branch `main` (nova API). NÃO usa `setup()` com `ensure_installed`/`highlight`/`auto_install` — essas opções não existem mais. O highlight é automático via ftplugin. Para instalar parsers: `:TSInstall <lang>`. Requer `tree-sitter-cli` instalado (`npm install -g tree-sitter-cli`). Parsers instalados: lua, vim, bash, json, yaml, markdown, markdown_inline, typescript, tsx, javascript, go, kotlin, clojure, elixir, heex, python, query, regex, gomod, gowork, gosum, html, hurl.
- `mason-lspconfig` tem `automatic_enable = { exclude = { "stylua" } }` para evitar que o stylua seja ativado como LSP server (conflito com none-ls que já o usa como formatter).
- Copilot: usa `github/copilot.vim` com npx. O `@github/copilot-language-server` é baixado via npx na primeira execução e fica em cache em `~/.npm/_npx/`. O warning "not found and will be installed" é normal apenas na primeira vez ou quando o servidor atualiza.
- Clipboard WSL: detectado automaticamente via `uname -r` em `options.lua`.
- O arquivo `debbuging.lua` tem typo no nome (intencionalmente mantido para não quebrar lazy).
- **Cliente HTTP**: usa `hurl.nvim` (arquivos `.hurl`), que chama o binário [Hurl](https://hurl.dev). O kulala.nvim foi removido porque o backend (kulala-core) virou código fechado e exige token de licença. Variáveis ficam em `vars.env` (formato `chave=valor`).
- **README.md** é público e usado por outras pessoas: toda dependência externa nova (binário, fonte, toolchain) deve ser adicionada na seção "📦 Requisitos", com comando de instalação para Arch, Ubuntu e macOS.
