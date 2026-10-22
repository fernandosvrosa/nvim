return {
  {
    -- Renderiza markdown dentro do próprio buffer (headings, listas, tabelas, code blocks)
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown" },
    keys = {
      { "<leader>mr", function() require("render-markdown").toggle() end, ft = "markdown", desc = "Markdown: Toggle render" },
    },
    opts = {},
  },
  {
    -- Preview no navegador com live reload (sem dependências externas)
    "brianhuster/live-preview.nvim",
    cmd = "LivePreview",
    keys = {
      { "<leader>mp", function() vim.cmd("LivePreview start") end, desc = "Markdown: Iniciar preview no navegador" },
      { "<leader>ms", function() vim.cmd("LivePreview close") end, desc = "Markdown: Parar preview" },
      { "<leader>mf", function() vim.cmd("LivePreview pick") end, desc = "Markdown: Escolher arquivo para preview" },
    },
  },
}
