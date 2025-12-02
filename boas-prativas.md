# Guia de Boas Práticas: Neovim (Polyglot Edition)
**Stack:** Golang, Java, Kotlin, Clojure, TypeScript/JavaScript

Este documento serve como referência de arquitetura para transformar o Neovim em uma IDE robusta, focando em performance, modularidade e estabilidade para o stack especificado.

## 1. Arquitetura de Diretórios
Não coloque tudo no `init.lua`. Use uma estrutura modular baseada em Lua para facilitar a manutenção.

**Estrutura Recomendada (`~/.config/nvim/`):**

```text
├── init.lua              # Apenas bootstrap do Lazy e carregamento de módulos 'config'
├── lazy-lock.json        # Gerado automaticamente (versões exatas dos plugins)
├── lua/
│   ├── config/           # Configurações core (carregadas no init.lua)
│   │   ├── lazy.lua      # Setup do gerenciador de plugins
│   │   ├── options.lua   # vim.opt (números de linha, tabs, encoding)
│   │   └── keymaps.lua   # Mapeamentos globais (Leader key, save, quit)
│   └── plugins/          # Módulos de plugins (specs do Lazy)
│       ├── lsp.lua       # Configuração base de LSP (Mason, LspConfig, Cmp)
│       ├── treesitter.lua
│       ├── formatting.lua
│       ├── debugging.lua
│       └── ...
└── ftplugin/             # CRUCIAL: Configurações específicas por tipo de arquivo
    └── java.lua          # Configuração isolada do nvim-jdtls (Java)
```

## 2. Gerenciamento de Plugins (Lazy.nvim)
Utilize o folke/lazy.nvim.

Lazy Loading: Nunca carregue plugins pesados na inicialização.

Use event = "VeryLazy" para plugins de UI.

Use ft = { "java", "go" } para plugins específicos de linguagem.

Lockfile: Mantenha o lazy-lock.json no controle de versão (Git) para garantir que sua IDE funcione igual em qualquer máquina.

## 3. Configuração de Linguagens (LSP & Tooling)
A base do ambiente deve ser composta por:

Mason.nvim: Para baixar binários (LSPs, Formatters, Debuggers).

Nvim-lspconfig: Para conectar o Neovim a esses binários.

🐹 Golang
LSP Server: gopls

Configurações Chave:

Habilitar staticcheck = true.

Habilitar gofumpt = true (formatação estrita).

Plugin Extra: ray-x/go.nvim.

Oferece comandos ricos como :GoAddTags (json/xml), :GoFillStruct e :GoTest.

☕ Java (Atenção Especial)
NÃO configure Java no setup global do lspconfig.

Ferramenta: mfussenegger/nvim-jdtls.

Como configurar: Crie o arquivo ftplugin/java.lua.

O Java requer que o servidor (Eclipse JDTLS) seja iniciado com parâmetros específicos (caminho do workspace, caminho do lombok.jar, versão do JDK).

O diretório ftplugin garante que essa lógica pesada só rode quando um arquivo .java for aberto.

📜 TypeScript / JavaScript
LSP Server: vtsls (Recomendado por ser mais rápido que o ts_ls/tsserver) ou ts_ls.

Formatação: Não use o LSP. Use Prettier via plugin de formatação.

React: Certifique-se de instalar o parser tsx no Treesitter.

🟣 Kotlin
LSP Server: kotlin_language_server.

Build System: O LSP exige um arquivo build.gradle.kts ou pom.xml na raiz para funcionar corretamente.

λ Clojure
O fluxo de Clojure é baseado em REPL, não apenas em análise estática.

LSP: clojure_lsp (Para navegação, rename, code actions).

REPL (Vital): Plugin Olical/conjure.

Permite avaliar formulários e buffers diretamente no editor, conectando-se ao nREPL.

Edição Estrutural: Use windwp/nvim-autopairs ou julienvincent/nvim-paredit.

## 4. Formatação e Linting
Use o plugin stevearc/conform.nvim. Ele padroniza a formatação entre linguagens.

Exemplo de Mapeamento:

Lua

formatters_by_ft = {
  lua = { "stylua" },
  go = { "goimports", "gofumpt" },
  javascript = { "prettier" },
  typescript = { "prettier" },
  -- Java geralmente usa o formatador do próprio LSP (jdtls)
  clojure = { "zprint" }, 
}
## 5. Debugging (DAP - Debug Adapter Protocol)
Use mfussenegger/nvim-dap em conjunto com rcarriga/nvim-dap-ui.

Go: Instale leoluz/nvim-dap-go. Configuração quase zero.

Java: No ftplugin/java.lua, é necessário injetar os bundles do java-debug e vscode-java-test na configuração do nvim-jdtls.

JS/TS: Use mxsdev/nvim-dap-vscode-js que faz a ponte com o debugger do VS Code.

## 6. Ferramentas Essenciais (Core)
Treesitter: Motor de parsing. Instale parsers para: go, java, kotlin, clojure, javascript, typescript, tsx, html, css.

Telescope: O "Google" do seu projeto.

Dependências de sistema: ripgrep e fd (para velocidade máxima).

Atalhos recomendados: <leader>f (arquivos), <leader>g (live grep).

Harpoon (ThePrimeagen): Para navegação rápida entre um conjunto pequeno de arquivos ativos (muito útil em projetos Java/Go grandes).

Gitsigns: Para ver o que mudou no arquivo em tempo real (coluna lateral).

## 7. Checklist de Performance
[ ] O arquivo init.lua é pequeno e apenas chama módulos?

[ ] Você está usando uma Nerd Font (ex: JetBrainsMono NF)?

[ ] O mason.nvim está configurado para instalar os servidores automaticamente?

[ ] A tecla <leader> está mapeada para Space?
