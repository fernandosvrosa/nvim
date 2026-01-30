return {
  {
    "mistweaverco/kulala.nvim",
    keys = {
      { "<leader>rr", function() require("kulala").run() end, desc = "Executar requisição HTTP" },
      { "<leader>ra", function() require("kulala").run_all() end, desc = "Executar todas as requisições" },
      { "<leader>rt", function() require("kulala").toggle_view() end, desc = "Alternar entre Body/Headers" },
    },
    opts = {
      -- Configurações opcionais
      display_mode = "split", -- Abre o resultado em um split lateral
      default_view = "body",  -- Mostra o corpo da resposta por padrão
    },
  },
}
