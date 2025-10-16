return {
	"danymat/neogen",
	config = function()
		local opts = { noremap = true, silent = true }
		vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate({ type = 'func' })<CR>", opts)
		vim.api.nvim_set_keymap("n", "<Leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>",
			opts)
		require('neogen').setup({
			languages = {
				python = {
					template = {
						annotation_convention = "numpydoc"
					}
				}
			},
			snippet_engine = "luasnip"
		})
	end,
	-- Uncomment next line if you want to follow only stable versions
	version = "*"
}
