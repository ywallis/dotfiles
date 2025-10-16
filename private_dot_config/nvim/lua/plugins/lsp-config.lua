return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	"neovim/nvim-lspconfig",
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				-- LSP
				"lua_ls",
				-- "zuban",
				-- "ty",
				-- "pyrefly",
				"basedpyright",
				"jsonls",
				"gopls",
				"ruff",
				"taplo",
				"bashls",
				"docker_compose_language_service",
				-- Conform
			},
		},
	},

	-- Configure format-on-save with conform.nvim.
	{
		"stevearc/conform.nvim",
		opts = {
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			-- Define formatters for filetypes.
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format", "ruff_organize_imports" },
			},
		},
	},

	-- Custom LSP configurations and overrides.
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Configure Ruff for linting.
			vim.lsp.config('ruff', {
				init_options = {
					settings = {
						logLevel = 'debug',
					},
				},
			})
			vim.lsp.enable('ruff')

			-- zuban
			-- vim.lsp.enable('zuban')
			-- ty
			-- vim.lsp.config('ty', {
			-- 	settings = {
			-- 		ty = {
			-- 			disableLanguageServices = false,
			-- 			diagnosticMode = 'workspace',
			-- 			experimental = {
			-- 				autoImport = true,
			-- 			},
			-- 		},
			-- 	},
			-- })
			-- vim.lsp.enable("ty")
			-- pyrefly
			-- vim.lsp.enable('pyrefly')
			-- based pyright
			vim.lsp.config("basedpyright", {
				settings = {
					basedpyright = {
						analysis = {
							typeCheckingMode = "standard",
							autoSearchPaths = true,
							diagnosticMode = "openFilesOnly",
							-- noticably slower
							-- diagnosticMode = "workspace",
							useLibraryCodeForTypes = true,
							autoSave = "onWindowChange",
							diagnosticSeverityOverrides = {
								reportUnusedVariable = "none",
								reportUnusedImport = "none",
							},
						},
					},
				}
			})
			vim.lsp.enable('basedpyright')


			-- bashls
			vim.lsp.enable("bashls")

			-- LuaLS
			vim.lsp.config('lua_ls', {
				settings = {
					Lua = {
						runtime = {
							version = 'LuaJIT',
						},
					},
				},
			})
			vim.lsp.enable('lua_ls')

			-- jsonls

			vim.lsp.enable('jsonls')
			-- gopls
			vim.lsp.enable("gopls")

			-- docker
			vim.lsp.enable("dockerls")

			-- docker compose
			vim.lsp.enable("docker_compose_language_service")
			local function set_filetype(pattern, filetype)
				vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
					pattern = pattern,
					command = "set filetype=" .. filetype,
				})
			end

			set_filetype({ "docker-compose.yml" }, "yaml.docker-compose")

			-- Keymaps and Hover
			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover,
				{ border = "rounded" })
			vim.keymap.set("n", "<leader>er", vim.diagnostic.open_float, {})
			vim.keymap.set("n", "<leader>en", vim.diagnostic.goto_next, {})
			vim.keymap.set("n", "<leader>ep", vim.diagnostic.goto_prev, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
			vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

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
