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
				ensure_installed = { "lua_ls", "basedpyright", "rust_analyzer" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({ capabilities = capabilities })
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
							-- reportUnknownMemberType = false,
							-- reportUnknownVariableType = false,
							-- reportUnknownArgumentType = false,
							-- reportUnknownReturnTypeError = false,
							-- reportUnknownImport = false,
							-- reportMissingModuleSource = false,
						},
					},
				},
			})
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
