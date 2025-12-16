return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		vim.opt.smartindent = false

		configs.setup({
			auto_install = true,
			ensure_installed = { "lua", "html", "python", "markdown", "markdown_inline" },
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
