return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      -- Busca fuzzy nativa em C (bem mais rápida em repos grandes); requer `make`
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      telescope.load_extension("ui-select")
      telescope.load_extension("fzf")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "buscar arquivos por nome" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Buscar arquivos por texto" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "buscar buffers abertos" })
    end,
  },
}
