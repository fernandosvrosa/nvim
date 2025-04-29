return {
  "nvim-treesitter/nvim-treesitter", 
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = { 
        "lua", 
        "javascript", 
        "go", 
        "java", 
        "clojure",
        "kotlin", 
        "typescript"
      },
      highligth = {enable = true },
      indent = { enable = true },
    })
  end
}
