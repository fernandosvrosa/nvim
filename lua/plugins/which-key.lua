return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      preset = "modern",
      -- Delay before showing the popup
      delay = function(ctx)
        return ctx.plugin and 0 or 200
      end,
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>c", group = "Code" }, -- Code actions
          { "<leader>d", group = "Debug" }, -- Debugging
          { "<leader>e", desc = "File Explorer" }, -- NeoTree
          { "<leader>f", group = "Find" }, -- Telescope
          { "<leader>g", group = "Git / LSP" }, -- Git or LSP related
          { "<leader>h", group = "Git Hunk" }, -- Git Hunk actions
          { "<leader>t", group = "Test / Go Tools" }, -- Testing and language specific tools
          
          -- Direct mappings descriptions can be reinforced here if needed,
          -- but usually 'desc' in keymap.set is enough.
          -- We focus on grouping here.
        },
      },
      win = {
        -- don't allow the popup to overlap with the cursor
        no_overlap = true,
        -- width = 1,
        -- height = { min = 4, max = 25 },
        -- col = 0,
        -- row = math.huge,
        border = "rounded",
        padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
        title = true,
        title_pos = "center",
        zindex = 1000,
      },
      layout = {
        width = { min = 20 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
      },
    })
  end,
}