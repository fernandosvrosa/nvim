return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  -- Nova API (branch main): não usa setup(). Use :TSInstall <lang> para instalar parsers.
  -- Requer: tree-sitter-cli (npm install -g tree-sitter-cli)
  config = function()
    -- O branch main não ativa o treesitter sozinho: inicia em todo buffer cuja linguagem tem parser instalado
    -- (highlight e plugins que dependem da árvore, como o hurl.nvim)
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
