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

			-- Generic on_attach function
			local on_attach = function(client)
				if client.name == "ruff" then
					client.server_capabilities.hoverProvider = false
				end
			end

			-- Gopls
			lspconfig.gopls.setup({ capabilities = capabilities, on_attach = on_attach })

			-- Lua ls
			lspconfig.lua_ls.setup({ capabilities = capabilities, on_attach = on_attach })

			-- Taplo
			lspconfig.taplo.setup({ on_attach = on_attach })

			-- Ruff
			lspconfig.ruff.setup({
				init_options = {
					settings = {
						organizeImports = true,
					},
				},
				on_attach = on_attach,
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
							autoSave = "onWindowChange",
							diagnosticSeverityOverrides = {
								reportUnusedVariable = "none",
								reportUnusedImport = "none",
							},
						},
					},
				},
			})

			-- Rust analyzer
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						diagnostics = {
							enable = false,
						},
					},
				},
			})

			-- Keymaps and Hover
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover,
				{ border = "rounded" })
			vim.keymap.set("n", "<leader>er", vim.diagnostic.open_float, {})
			vim.keymap.set("n", "<leader>en", vim.diagnostic.goto_next, {})
			vim.keymap.set("n", "<leader>ep", vim.diagnostic.goto_prev, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

			-- Diagnostics config
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = true,
				severity_sort = false,
				float = {
					border = "rounded",
				},
			})

			-- Autocmd for diagnostics
			vim.api.nvim_create_autocmd("CursorHold", {
				group = vim.api.nvim_create_augroup("LspDiagnostics", { clear = true }),
				callback = function()
					vim.diagnostic.open_float(nil, { focus = false })
				end,
				desc = "Show diagnostics on CursorHold",
			})
		end,
	},
}
