return {
  {
    -- Cliente HTTP para arquivos .hurl (requer o binário `hurl` e `jq` instalados no sistema)
    "jellydn/hurl.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = "hurl",
    keys = {
      { "<leader>rr", function() vim.cmd("HurlRunnerAt") end, ft = "hurl", desc = "Hurl: Executar requisição sob o cursor" },
      { "<leader>ra", function() vim.cmd("HurlRunner") end, ft = "hurl", desc = "Hurl: Executar todas as requisições do arquivo" },
      { "<leader>ra", ":HurlRunner<CR>", mode = "v", ft = "hurl", desc = "Hurl: Executar requisições selecionadas" },
      { "<leader>re", function() vim.cmd("HurlRunnerToEntry") end, ft = "hurl", desc = "Hurl: Executar do início até a requisição atual" },
      { "<leader>rs", function() vim.cmd("HurlRerun") end, ft = "hurl", desc = "Hurl: Repetir última execução" },
      { "<leader>rl", function() vim.cmd("HurlShowLastResponse") end, ft = "hurl", desc = "Hurl: Mostrar última resposta" },
      { "<leader>rt", function() vim.cmd("HurlToggleMode") end, ft = "hurl", desc = "Hurl: Alternar split/popup" },
      { "<leader>rv", function() vim.cmd("HurlVerbose") end, ft = "hurl", desc = "Hurl: Executar em modo verbose" },
      { "<leader>rm", function() vim.cmd("HurlManageVariable") end, ft = "hurl", desc = "Hurl: Gerenciar variáveis" },
    },
    opts = {
      mode = "split",
      -- Arquivos de variáveis procurados (formato chave=valor)
      env_file = { "vars.env" },
    },
  },
}
