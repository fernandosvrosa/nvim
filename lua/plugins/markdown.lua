return {
  {
    -- Renderiza markdown dentro do próprio buffer (headings, listas, tabelas, code blocks)
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown" },
    keys = {
      { "<leader>mr", function() require("render-markdown").toggle() end, ft = "markdown", desc = "Markdown: Toggle render" },
    },
    opts = {},
  },
  {
    -- Preview no navegador com live reload (sem dependências externas)
    "brianhuster/live-preview.nvim",
    cmd = "LivePreview",
    keys = {
      {
        "<leader>mp",
        function()
          -- Free the preview port before starting, so the latest request always wins.
          local port = require("livepreview.config").config.port
          local own_pid = vim.uv.os_getpid()
          for _, proc in ipairs(require("livepreview.utils").processes_listening_on_port(port)) do
            if proc.pid ~= own_pid then
              local sock = vim.fs.joinpath(vim.fn.stdpath("run"), ("nvim.%d.0"):format(proc.pid))
              local closed = false
              if proc.name:match("^nvim") and vim.uv.fs_stat(sock) then
                -- Another Neovim instance: stop only its preview server, keep the editor alive.
                local ok, chan = pcall(vim.fn.sockconnect, "pipe", sock, { rpc = true })
                if ok and chan > 0 then
                  closed = pcall(vim.rpcrequest, chan, "nvim_exec_lua", 'require("livepreview").close()', {})
                  vim.fn.chanclose(chan)
                end
              end
              if not closed then
                vim.uv.kill(proc.pid, "sigterm")
              end
              vim.notify(("live-preview: porta %d liberada (%s, PID %d)"):format(port, proc.name, proc.pid))
            end
          end
          vim.wait(1000, function()
            for _, p in ipairs(require("livepreview.utils").processes_listening_on_port(port)) do
              if p.pid ~= own_pid then
                return false
              end
            end
            return true
          end, 100)
          vim.cmd("LivePreview start")
        end,
        desc = "Markdown: Iniciar preview no navegador",
      },
      { "<leader>ms", function() vim.cmd("LivePreview close") end, desc = "Markdown: Parar preview" },
      { "<leader>mf", function() vim.cmd("LivePreview pick") end, desc = "Markdown: Escolher arquivo para preview" },
    },
    opts = {
      -- Serve from the file's own directory instead of Neovim's cwd.
      -- Without this, files outside cwd yield a 404 / "bad argument to 'format'" error.
      dynamic_root = true,
    },
  },
}
