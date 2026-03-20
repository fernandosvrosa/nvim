return {
  "ray-x/go.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("go").setup({
      -- Configuration options for go.nvim
      -- You can customize this later if you want
    })

    -- Keymaps for go.nvim functionalities
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Run tests
    map("n", "<leader>tt", function() vim.cmd("GoTest") end,      { desc = "Run Go tests" })
    map("n", "<leader>tf", function() vim.cmd("GoTestFunc") end,  { desc = "Run Go test function" })
    map("n", "<leader>tC", function() vim.cmd("GoCoverage") end,  { desc = "Run Go test coverage" })

    -- Add/remove struct tags
    map("n", "<leader>ts", function() vim.cmd("GoAddTags") end,    { desc = "Add struct tags" })
    map("n", "<leader>tr", function() vim.cmd("GoRemoveTags") end, { desc = "Remove struct tags" })
  end,
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
