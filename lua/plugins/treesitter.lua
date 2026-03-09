return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    -- A nova API do nvim-treesitter (branch main) não usa setup() com
    -- ensure_installed/highlight/auto_install. O highlight é ativado
    -- automaticamente via ftplugin. Use :TSInstall <lang> para instalar novos parsers.
    -- tree-sitter CLI necessário: npm install -g tree-sitter-cli
  end,
}
