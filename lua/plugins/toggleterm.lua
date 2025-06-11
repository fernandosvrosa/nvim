return {
  {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup {
      size = 20,
      open_mapping = [[<C-\>]],
      direction = "horizontal", -- ou "vertical" ou "float"
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
    }

    -- Atalho para abrir REPL diretamente em um terminal específico
    local Terminal = require("toggleterm.terminal").Terminal

    local clojure_repl = Terminal:new({
      cmd = "clj", -- ou "lein repl" se você usa Leiningen
      hidden = true,
      direction = "horizontal",
      close_on_exit = false,
    })

    vim.keymap.set("n", "<leader>rc", function()
      clojure_repl:toggle()
    end, { desc = "Abrir Clojure REPL (clj)", noremap = true, silent = true })
  end,
}
}
