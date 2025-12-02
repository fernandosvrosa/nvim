-- ftplugin/java.lua

-- Somente executa se nvim-jdtls estiver instalado
local jdtls_status, jdtls = pcall(require, "jdtls")
if not jdtls_status then
	vim.notify("nvim-jdtls não encontrado. A configuração Java será ignorada.", vim.log.levels.WARN)
	return
end

-- --- Variáveis de Configuração ---
local home = os.getenv("HOME")
local mason_path = vim.fn.stdpath("data") .. "/mason"

-- --- Detecção de Sistema Operacional e Caminhos ---
local os_name = vim.loop.os_uname().sysname
local java_debug_path
local vscode_java_test_path
local jdtls_path

if os_name == "Darwin" then -- macOS
	jdtls_path = mason_path .. "/packages/jdtls/bin/jdtls"
	java_debug_path = mason_path .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.39.0.jar"
	vscode_java_test_path = mason_path .. "/packages/vscode-java-test/extension/server/*.jar"
elseif os_name == "Linux" then
	jdtls_path = mason_path .. "/packages/jdtls/bin/jdtls"
	java_debug_path = mason_path .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
	vscode_java_test_path = mason_path .. "/packages/vscode-java-test/extension/server/*.jar"
else -- Windows
	-- Adapte os caminhos se necessário para Windows
	jdtls_path = mason_path .. "/packages/jdtls/jdtls.bat"
	java_debug_path = "" -- Preencha com o caminho correto
	vscode_java_test_path = "" -- Preencha com o caminho correto
end

-- --- Definição do Workspace ---
-- Cria um diretório de workspace por projeto, baseado no diretório raiz do Git
local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" })
local workspace_dir = home .. "/.local/share/nvim/jdtls-workspaces/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- --- Configuração do Comando JDTLS ---
local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1.XmlServerApplication",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		vim.fn.glob(mason_path .. "/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		mason_path .. "/packages/jdtls/config_" .. (os_name == "Linux" and "linux" or "mac"),
		"-data",
		workspace_dir,
	},

	-- --- Configuração do Servidor LSP ---
	root_dir = root_dir,

	-- --- Configuração do Debugger (DAP) ---
	on_attach = function(client, bufnr)
		-- Delega a configuração do DAP ao jdtls
		jdtls.setup_dap({ hotcodereplace = "auto" })

		-- Atalhos específicos para Java
		local map = vim.keymap.set
		local opts = { noremap = true, silent = true, buffer = bufnr }

		map("n", "<leader>jo", jdtls.organize_imports, vim.tbl_extend("force", opts, { desc = "Organize Imports" }))
		map("n", "<leader>jt", jdtls.test_class, vim.tbl_extend("force", opts, { desc = "Test Class" }))
		map("n", "<leader>jT", jdtls.test_nearest_method, vim.tbl_extend("force", opts, { desc = "Test Method" }))
		map(
			"v",
			"<leader>je",
			"<ESC><CMD>lua require('jdtls').extract_variable(true)<CR>",
			vim.tbl_extend("force", opts, { desc = "Extract Variable" })
		)
		map(
			"n",
			"<leader>jc",
			"<CMD>lua require('jdtls').extract_constant(vim.fn.input('Constant name: '))<CR>",
			vim.tbl_extend("force", opts, { desc = "Extract Constant" })
		)
	end,

	-- --- Bundles de Debug e Testes ---
	init_options = {
		bundles = {
			vim.fn.glob(java_debug_path),
			vim.fn.glob(vscode_java_test_path),
		},
	},
}

-- --- Iniciar o JDTLS ---
jdtls.start_or_attach(config)
