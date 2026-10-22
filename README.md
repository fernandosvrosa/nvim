## Welcome with my nvim config

Configuração do Neovim usando [lazy.nvim](https://github.com/folke/lazy.nvim). Os plugins são instalados sozinhos na primeira vez que o Neovim abre; os servidores LSP, formatters e linters são instalados pelo [Mason](https://github.com/williamboman/mason.nvim). O que **não** é instalado automaticamente está listado abaixo.

## 📦 Requisitos

### Obrigatórios

| Ferramenta | Para quê | Arch Linux | Ubuntu/Debian | macOS (Homebrew) |
| :--- | :--- | :--- | :--- | :--- |
| **Neovim 0.12+** | O nvim-treesitter (branch `main`) exige 0.12 | `pacman -S neovim` | [AppImage/PPA](https://github.com/neovim/neovim/blob/master/INSTALL.md) | `brew install neovim` |
| **git** | lazy.nvim baixa os plugins via git | `pacman -S git` | `apt install git` | `brew install git` |
| **Nerd Font** | Ícones (neo-tree, lualine, render-markdown) | `pacman -S ttf-jetbrains-mono-nerd` | [nerdfonts.com](https://www.nerdfonts.com/) | `brew install --cask font-jetbrains-mono-nerd-font` |
| **make + gcc** | Compilar `telescope-fzf-native` e os parsers do treesitter | `pacman -S base-devel` | `apt install build-essential` | `xcode-select --install` |
| **tree-sitter-cli** | Instalar parsers com `:TSInstall` | `pacman -S tree-sitter-cli` | `npm install -g tree-sitter-cli` | `brew install tree-sitter-cli` |
| **ripgrep** | Busca de texto do Telescope (`<leader>fg`) | `pacman -S ripgrep` | `apt install ripgrep` | `brew install ripgrep` |
| **fd** | Busca de arquivos do Telescope (opcional, mais rápido) | `pacman -S fd` | `apt install fd-find` | `brew install fd` |
| **Node.js + npm** | Copilot, vtsls, prettierd e debugger JS | `pacman -S nodejs npm` | [nodejs.org](https://nodejs.org/) | `brew install node` |
| **curl, unzip, tar, gzip** | Usados pelo Mason para baixar as ferramentas | `pacman -S curl unzip` | `apt install curl unzip` | já vem no sistema |

### Cliente HTTP (hurl.nvim)

| Ferramenta | Para quê | Arch Linux | Ubuntu/Debian | macOS (Homebrew) |
| :--- | :--- | :--- | :--- | :--- |
| **[hurl](https://hurl.dev)** | Executa as requisições dos arquivos `.hurl` | `pacman -S hurl` | [.deb do release](https://hurl.dev/docs/installation.html#debian--ubuntu) | `brew install hurl` |
| **jq** | Formata respostas JSON | `pacman -S jq` | `apt install jq` | `brew install jq` |
| prettier *(opcional)* | Formata respostas HTML | `npm install -g prettier` | `npm install -g prettier` | `npm install -g prettier` |
| tidy *(opcional)* | Formata respostas XML | `pacman -S tidy` | `apt install tidy` | `brew install tidy-html5` |

Depois de instalar, rode `:TSInstall hurl` para ter o highlight dos arquivos `.hurl`.

### Por linguagem (só instale as que você usa)

| Linguagem | O que instalar | Observação |
| :--- | :--- | :--- |
| **Go** | [Go](https://go.dev/dl/) + delve (`go install github.com/go-delve/delve/cmd/dlv@latest`) | `gopls`, `goimports`, `gofumpt` e `golangci-lint` vêm pelo Mason. |
| **Java / Kotlin** | JDK 21+ | `jdtls` e `kotlin_language_server` vêm pelo Mason. |
| **Clojure** | JDK + [Clojure CLI](https://clojure.org/guides/install_clojure) (`clj`) | Usado pelo REPL (`<leader>rc`) e pelo Conjure. `clojure_lsp`, `clj-kondo` e `zprint` vêm pelo Mason. |
| **Elixir** | [Elixir](https://elixir-lang.org/install.html) (inclui `mix`) | `mix format` é usado como formatter. `elixirls` vem pelo Mason. |
| **TypeScript / JavaScript** | Node.js | `vtsls` e `prettierd` vêm pelo Mason. |
| **Lua** | — | `lua_ls` e `stylua` vêm pelo Mason. |

### Opcionais

| Ferramenta | Para quê |
| :--- | :--- |
| [Rust/cargo](https://rustup.rs) | Ativar o `parinfer-rust` (comentado em `conjure-repl.lua`). |
| [Claude Code](https://claude.com/claude-code) (`claude`) | Terminal do Claude em `<leader>ai`. |
| Conta do GitHub Copilot | Rodar `:Copilot setup` na primeira vez. |
| WSL | O clipboard do Windows é detectado sozinho (usa `clip.exe` e `powershell.exe`). |

### Verificando a instalação

```
:checkhealth
:checkhealth telescope
:checkhealth render-markdown
:Mason
```

---

## 🧩 Guia de Uso

> **Dica:** `<leader>` é a tecla **Espaço** e `<localleader>` é a **vírgula** (`,`). Aperte `Espaço` e espere um instante: o **which-key** abre um menu com todos os atalhos disponíveis, agrupados por categoria.

### ⌨️ Atalhos gerais

| Atalho | Modo | O que faz |
| :--- | :--- | :--- |
| `<leader>w` | normal | Salvar arquivo |
| `<leader>q` | normal | Fechar janela |
| `<leader>Q` | normal | Sair de tudo |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | normal | Ir para o split da esquerda / baixo / cima / direita |
| `<Esc>` | normal | Limpar o destaque da busca |
| `J` / `K` | visual | Mover as linhas selecionadas para baixo / cima |
| `<` / `>` | visual | Diminuir / aumentar a indentação sem perder a seleção |

### 🧠 LSP (inteligência de código)

Os servidores de linguagem são instalados pelo Mason (`:Mason` para ver o status). Os atalhos só existem em buffers com LSP ativo.

| Atalho | O que faz |
| :--- | :--- |
| `K` | Documentação do símbolo sob o cursor |
| `gd` | Ir para a definição |
| `gD` | Ir para a declaração |
| `gi` | Ir para a implementação |
| `gy` | Ir para a definição do tipo |
| `gr` | Listar referências |
| `<leader>rn` | Renomear símbolo em todo o projeto |
| `<leader>ca` | Code actions (imports, correções rápidas...) — também no modo visual |
| `<leader>gf` | Formatar o arquivo |
| `]d` / `[d` | Próximo / anterior diagnóstico (erro, aviso) |
| `<leader>cd` | Mostrar o diagnóstico da linha em uma janela flutuante |

**Formatação ao salvar:** ao salvar (`:w`), o arquivo é formatado automaticamente pelo formatter da linguagem (stylua, prettierd, goimports/gofumpt, zprint, mix format).

### ✍️ Autocomplete e IA

| Plugin | Como usar |
| :--- | :--- |
| **nvim-cmp** | O menu aparece enquanto você digita.<br>`<C-Space>` forçar o menu · `<CR>` confirmar · `<C-e>` cancelar · `<C-b>`/`<C-f>` rolar a documentação |
| **LuaSnip + friendly-snippets** | Snippets prontos para várias linguagens aparecem no mesmo menu. |
| **Copilot** | Sugestões aparecem como texto fantasma; `Tab` aceita. Na primeira vez rode `:Copilot setup` para logar no GitHub. |
| **Claude Code** | `<leader>ai` abre o `claude` em um terminal flutuante (requer o Claude Code instalado). |

### 🛠️ Navegação e arquivos

| Plugin | Atalhos / Comandos |
| :--- | :--- |
| **Telescope** | `<C-p>` buscar arquivos por nome<br>`<leader>fg` buscar texto em todos os arquivos (grep)<br>`<leader>fb` buscar entre os buffers abertos<br>Dentro do Telescope: setas ou `<C-n>`/`<C-p>` para navegar, `<CR>` abrir, `<C-x>`/`<C-v>` abrir em split horizontal/vertical, `<Esc>` fechar |
| **Neo-tree** | `<leader>e` abrir/fechar a árvore de arquivos<br>Dentro dela: `a` criar arquivo/pasta, `d` apagar, `r` renomear, `c` copiar, `m` mover, `H` mostrar ocultos, `?` ajuda |
| **Oil.nvim** | `-` abre a pasta atual numa janela flutuante. Edite os nomes como texto e salve com `:w` para renomear, mover, criar ou apagar arquivos. |
| **Toggleterm** | `<C-\>` abrir/fechar o terminal<br>`<leader>rc` abrir o REPL do Clojure (`clj`) |

### 🌿 Git (gitsigns)

As alterações aparecem na coluna da esquerda. Um *hunk* é um bloco de linhas alteradas.

| Atalho | O que faz |
| :--- | :--- |
| `]c` / `[c` | Próximo / anterior hunk |
| `<leader>hp` | Pré-visualizar o hunk |
| `<leader>hs` / `<leader>hr` | Stage / reset do hunk (no modo visual, só das linhas selecionadas) |
| `<leader>hu` | Desfazer o último stage |
| `<leader>hS` / `<leader>hR` | Stage / reset do arquivo inteiro |
| `<leader>hb` | Blame completo da linha |
| `<leader>tb` | Liga/desliga o blame inline na linha atual |
| `<leader>hd` / `<leader>hD` | Diff do arquivo contra o index / contra o último commit |
| `<leader>td` | Mostrar/ocultar as linhas apagadas |

### 🐞 Debug (nvim-dap)

A interface (dap-ui) abre sozinha ao iniciar o debug e fecha ao terminar. Configurado para **Go** (delve) e **JavaScript/TypeScript**.

| Atalho | O que faz |
| :--- | :--- |
| `<leader>db` | Liga/desliga breakpoint na linha |
| `<F5>` | Iniciar / continuar |
| `<F10>` | Step over (próxima linha) |
| `<F11>` | Step into (entrar na função) |
| `<F12>` | Step out (sair da função) |
| `<leader>dr` | Abrir/fechar o REPL do debugger |

### ⚡ Edição

| Plugin | Como usar |
| :--- | :--- |
| **Comment.nvim** | `gcc` comentar a linha · `gc` no modo visual comentar a seleção · `gc3j` comentar 3 linhas para baixo |
| **nvim-surround** | `ysiw"` colocar `"` em volta da palavra · `ds"` remover as `"` · `cs"'` trocar `"` por `'` · `S"` no modo visual |
| **vim-visual-multi** | `<C-n>` selecionar a palavra e as próximas ocorrências (cada `<C-n>` adiciona mais uma) · `<C-Down>`/`<C-Up>` adicionar cursores na vertical · `q` pular uma ocorrência · `<Esc>` sair |
| **nvim-autopairs** | Fecha parênteses, colchetes e aspas automaticamente. |

### 🔧 Linguagens específicas

| Plugin | Atalhos / Comandos |
| :--- | :--- |
| **go.nvim** (Go) | `<leader>tt` rodar os testes · `<leader>tf` rodar o teste sob o cursor · `<leader>tC` cobertura · `<leader>ts`/`<leader>tr` adicionar/remover tags na struct |
| **Conjure** (Clojure, Fennel) | Abra o REPL (`<leader>rc` ou `clj` em outro terminal) e avalie o código:<br>`<leader>ee` avaliar a forma atual · `<leader>ef` avaliar o arquivo · `<leader>er` recarregar o namespace · `<leader>ed` documentação da palavra sob o cursor<br>O Conjure também tem os próprios atalhos com `<localleader>` (`,`); veja `:help conjure`. |
| **vim-sexp** (Clojure) | Edição estrutural de parênteses: `>)` / `<)` empurrar/puxar o parêntese de fechamento, `>f` / `<f` mover a forma. |

### 📝 Markdown

| Plugin | Atalhos / Comandos |
| :--- | :--- |
| **render-markdown.nvim** | Mostra o markdown formatado dentro do próprio buffer (títulos, tabelas, checkboxes, blocos de código). Automático em arquivos `.md`; a linha do cursor e o modo insert mostram o texto cru para editar.<br>`<leader>mr` liga/desliga o render |
| **live-preview.nvim** | Abre o markdown (ou HTML) no navegador, atualizando enquanto você digita.<br>`<leader>mp` iniciar o preview · `<leader>ms` parar · `<leader>mf` escolher outro arquivo |

### 🌐 Cliente HTTP (hurl.nvim)

Requisições HTTP ficam em arquivos `.hurl` e são executadas pelo [Hurl](https://hurl.dev) (veja os [requisitos](#cliente-http-hurlnvim)). Como o Hurl é uma ferramenta de linha de comando, os mesmos arquivos também rodam no terminal e no CI.

#### Atalhos (em arquivos `.hurl`)

| Atalho | O que faz |
| :--- | :--- |
| `<leader>rr` | Executa a requisição sob o cursor |
| `<leader>ra` | Executa todas as requisições do arquivo (no modo visual, só as selecionadas) |
| `<leader>re` | Executa do início do arquivo até a requisição atual (útil quando ela depende de um login antes) |
| `<leader>rs` | Repete a última execução |
| `<leader>rl` | Mostra de novo a última resposta |
| `<leader>rt` | Alterna a exibição da resposta entre split e popup |
| `<leader>rv` | Executa em modo verbose (mostra a requisição e os headers enviados/recebidos) |
| `<leader>rm` | Ver e editar as variáveis |

Na janela de resposta, `q` fecha.

#### Formato básico

Cada requisição é: **método + URL**, depois os **headers**, depois o **body**. Uma linha `HTTP <status>` opcional verifica o status. Requisições são separadas apenas pela próxima linha com método.

```hurl
# GET simples
GET https://jsonplaceholder.typicode.com/posts/1

# GET verificando o status
GET https://jsonplaceholder.typicode.com/posts/1
HTTP 200
```

#### Query params, headers e body

```hurl
# Query params (equivale a ?userId=1&_limit=5)
GET https://jsonplaceholder.typicode.com/posts
[Query]
userId: 1
_limit: 5

# POST com JSON e headers
POST https://jsonplaceholder.typicode.com/posts
Content-Type: application/json
Accept: application/json
{
  "title": "Meu post",
  "body": "Conteúdo",
  "userId": 1
}
HTTP 201

# PUT e DELETE
PUT https://jsonplaceholder.typicode.com/posts/1
Content-Type: application/json
{ "id": 1, "title": "Atualizado", "body": "Novo conteúdo", "userId": 1 }

DELETE https://jsonplaceholder.typicode.com/posts/1
HTTP 200

# Formulário (application/x-www-form-urlencoded)
POST https://httpbin.org/post
[Form]
usuario: fernando
lembrar: true

# Upload de arquivo (multipart/form-data)
POST https://httpbin.org/post
[Multipart]
descricao: Meu arquivo
arquivo: file,dados.txt;

# Autenticação Basic
GET https://httpbin.org/basic-auth/user/pass
[BasicAuth]
user: pass
```

#### Variáveis e ambientes

Use `{{nome}}` para variáveis. Elas ficam em um arquivo `vars.env` na mesma pasta do `.hurl` (ou em uma pasta acima), no formato `chave=valor`:

```
# vars.env
baseUrl=http://localhost:8080
user=fernando
password=segredo
```

```hurl
GET {{baseUrl}}/health
HTTP 200
```

Para ter vários ambientes, crie um arquivo por ambiente (por exemplo `vars.env`, `staging.env`, `prod.env`) e troque com `:HurlSelectEnvFile`. Para mudar uma variável só na sessão atual: `:HurlSetVariable baseUrl http://localhost:3000`.

> ⚠️ Se o arquivo de variáveis tiver senhas ou tokens, coloque-o no `.gitignore`.

#### Encadeando requisições (login → token)

`[Captures]` salva valores da resposta em variáveis que as requisições seguintes do mesmo arquivo podem usar. Execute com `<leader>ra` (todas) ou `<leader>re` (até a atual).

```hurl
# 1. Login
POST {{baseUrl}}/auth/login
Content-Type: application/json
{
  "user": "{{user}}",
  "password": "{{password}}"
}
HTTP 200
[Captures]
token: jsonpath "$.token"

# 2. Criar um pedido usando o token
POST {{baseUrl}}/orders
Authorization: Bearer {{token}}
Content-Type: application/json
{ "product": "teclado", "quantity": 1 }
HTTP 201
[Captures]
orderId: jsonpath "$.id"

# 3. Buscar o pedido criado
GET {{baseUrl}}/orders/{{orderId}}
Authorization: Bearer {{token}}
HTTP 200
```

Além de `jsonpath`, dá para capturar com `header "Nome"`, `cookie "nome"`, `regex "padrão"` e `xpath "..."`.

#### Verificando respostas (testes)

`[Asserts]` transforma o arquivo em teste de API: se alguma verificação falhar, o Hurl mostra qual foi.

```hurl
GET {{baseUrl}}/orders
Authorization: Bearer {{token}}
HTTP 200
[Asserts]
header "Content-Type" contains "application/json"
jsonpath "$.orders" count > 0
jsonpath "$.orders[0].id" exists
jsonpath "$.orders[0].status" == "PAID"
jsonpath "$.total" >= 100
duration < 1000
```

#### No terminal e no CI

```bash
# Executar e ver a resposta da última requisição
hurl --variables-file vars.env api.hurl

# Ver tudo que foi enviado/recebido
hurl --very-verbose --variables-file vars.env api.hurl

# Rodar como testes (relatório de sucesso/falha)
hurl --test --variables-file vars.env tests/*.hurl

# Passar uma variável na hora
hurl --variable baseUrl=http://localhost:3000 api.hurl
```

Documentação completa do formato: [hurl.dev/docs/hurl-file.html](https://hurl.dev/docs/hurl-file.html) · Exemplos: [hurl.dev/docs/samples.html](https://hurl.dev/docs/samples.html).

### 🎨 Visual e interface

*   **Catppuccin:** tema de cores.
*   **Alpha:** tela inicial (dashboard) ao abrir o `nvim` sem arquivo.
*   **Lualine:** barra de status no rodapé (modo, branch do git, diagnósticos).
*   **Indent-blankline:** linhas verticais que mostram a indentação.
*   **Which-key:** menu de atalhos ao apertar `Espaço` (ou qualquer prefixo) e esperar.
*   **Treesitter:** destaque de sintaxe. Para instalar o parser de outra linguagem: `:TSInstall <linguagem>`.

## 🩺 Problemas comuns

| Problema | Solução |
| :--- | :--- |
| Ícones aparecem como quadrados ou `?` | Instale uma Nerd Font e configure o terminal para usá-la. |
| `<leader>fg` não encontra nada | Instale o `ripgrep` e rode `:checkhealth telescope`. |
| Erro ao compilar `telescope-fzf-native` | Instale `make` e `gcc` e rode `:Lazy build telescope-fzf-native.nvim`. |
| Sem cor de sintaxe em alguma linguagem | `:TSInstall <linguagem>` (requer o `tree-sitter-cli`). |
| LSP não inicia | Abra `:Mason` para ver se o servidor instalou e `:checkhealth vim.lsp` para detalhes. |
| `<leader>rr` não faz nada em `.hurl` | Verifique se o `hurl` está instalado (`hurl --version`). |
| Plugins desatualizados ou com erro | `:Lazy sync` atualiza tudo; `:Lazy` mostra o status de cada plugin. |
