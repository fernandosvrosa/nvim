return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  -- Nova API (branch main): não usa setup(). Highlight ativado automaticamente.
  -- Use :TSInstall <lang> para instalar parsers. Requer: npm install -g tree-sitter-cli
}
