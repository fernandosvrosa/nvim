return {
  {
    "mistweaverco/kulala.nvim",
    keys = {
      -- Tente este se o show_results falhar: ele re-executa a última chamando a janela
      { "<leader>rs", function() require("kulala").replay() end, desc = "Kulala: Repetir/Mostrar última resposta" },
      { "<leader>rr", function() require("kulala").run() end, desc = "Executar requisição HTTP" },
      { "<leader>ra", function() require("kulala").run_all() end, desc = "Executar todas as requisições" },
      { "<leader>rt", function() require("kulala").toggle_view() end, desc = "Alternar entre Body/Headers" },
      -- Abrir o histórico de buscas (seletor)
      { "<leader>rh", function() require("kulala").search() end, desc = "Kulala: Procurar no histórico" },
    },
    opts = {
      display_mode = "split",
      default_view = "body",
      -- Garante que o kulala não feche o buffer de resultados agressivamente
      scratchpad_default_contents = { "@env = dev", "GET https://httpbin.org/get HTTP/1.1" },
    },
  },
}
