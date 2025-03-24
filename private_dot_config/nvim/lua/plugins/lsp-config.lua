return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "basedpyright", "rust_analyzer", "taplo", "ruff", "gopls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			-- Gopls
			lspconfig.gopls.setup({})
			--Lua ls
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			-- Taplo
			lspconfig.taplo.setup({})
			-- Ruff
			lspconfig.ruff.setup({
				init_options = {
					settings = {
						organizeImports = true,
					},
				},
				on_attach = function(client)
					client.server_capabilities.hoverProvider = false -- Keep hover from Pyright
					client.server_capabilities.definitionProvider = false -- Prevent conflicts with Pyright
					client.server_capabilities.referencesProvider = false -- Keep references from Pyright
				end,
			})
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client == nil then
						return
					end
					if client.name == "ruff" then
						-- Disable hover in favor of Pyright
						client.server_capabilities.hoverProvider = false
					end
				end,
				desc = "LSP: Disable hover capability from Ruff",
			})
			-- Based pyright
			lspconfig.basedpyright.setup({
				capabilities = capabilities,
				settings = {
					basedpyright = {
						analysis = {
							typeCheckingMode = "standard",
							autoSearchPaths = true,
							diagnosticMode = "openFilesOnly",
							useLibraryCodeForTypes = true,
							autoSave = "onWindowChange", -- Auto save when window changes (can also use "afterDelay")
							diagnosticSeverityOverrides = {
								reportUnusedVariable = "none",
								reportUnusedImport = "none",
								reportDuplicateImport = "none",
								reportPrivateUsage = "none",
								reportUnnecessaryCast = "none",
								reportShadowedImports = "none",
							},
						},
					},
				},
			})
			-- Rust analyzer
			lspconfig.rust_analyzer.setup({ capabilities = capabilities }, {
				settings = {
					["rust-analyzer"] = {
						diagnostics = {
							enable = false,
						},
					},
				},
			})

			-- Mapping and format for hover
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

			-- Mapping and format for diagnostics
			vim.keymap.set("n", "<leader>er", vim.diagnostic.open_float)
			vim.diagnostic.config({
				{
					virtual_text = true,
					signs = true,
					underline = true,
					update_in_insert = true,
					severity_sort = false,
				},
				float = {
					border = "rounded", -- Use "rounded", "single", "double", "solid", etc.
				},
			})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
