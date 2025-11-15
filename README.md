## Welcome with my nvim config 

If you are unable to search with telescope, run this command to see if you have installed the dependencies it needs on the OS.


```
:checkhealth telescope
```

## Go Development Dependencies

For Go development, you need to install the following tools:

- **gopls (Language Server):**
  ```bash
  go install golang.org/x/tools/gopls@latest
  ```

- **golangci-lint (Linter):**
  ```bash
  go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
  ```

- **delve (Debugger):**
  ```bash
  go install github.com/go-delve/delve/cmd/dlv@latest
  ```