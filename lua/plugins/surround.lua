-- lua/plugins/surround.lua
return {
  "kylechui/nvim-surround",
  version = "*", -- Use a versão mais recente
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- sua configuração aqui
    })
  end,
}