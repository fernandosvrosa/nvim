return {
  {
    "stevearc/oil.nvim",
    config = function()
      local oil = require("oil")
      oil.setup({
        default_file_explorer = false, -- para manter Neo-tree como default
      })
      vim.keymap.set("n", "-", oil.toggle_float, {})
    end,
  },
}
