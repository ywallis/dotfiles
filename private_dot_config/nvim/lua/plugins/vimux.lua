return {
	{
		"preservim/vimux",

		config = function()
			vim.api.nvim_set_keymap(
				"n",
				"<leader>ur",
				":call VimuxRunCommandInDir('uv run', 1)<CR>",
				{ noremap = true, silent = true }
			)
			-- vim.api.nvim_set_keymap("n", "<leader>cr", ":call VimuxRunCommandInDir('cargo run', 1)<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>vq", ":VimuxCloseRunner<CR>",
				{ noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>vx", ":VimuxInterruptRunner<CR>",
				{ noremap = true, silent = true })
		end,
	},
	{

		"jtdowney/vimux-cargo",

		config = function()
			vim.api.nvim_set_keymap("n", "<leader>cr", ":wa<CR> :CargoRun<CR>", { noremap = true, silent = true })
		end,
	},
}
