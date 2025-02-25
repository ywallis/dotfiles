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
			vim.keymap.set("n", "<leader>um", function()
				local file_path = vim.fn.expand("%:p:r") -- Get full path without extension
				local cwd = vim.fn.getcwd() -- Get the current working directory
				local rel_path = file_path:gsub(cwd .. "/", "") -- Remove the working directory part
				local module_path = rel_path:gsub("/", ".") -- Convert path to module format

				local command = "uv run -m " .. module_path -- Final command
				vim.fn.VimuxRunCommand(command) -- Execute in Vimux
			end, { noremap = true, silent = true })
			-- vim.api.nvim_set_keymap("n", "<leader>cr", ":call VimuxRunCommandInDir('cargo run', 1)<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>vq", ":VimuxCloseRunner<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>vx", ":VimuxInterruptRunner<CR>", { noremap = true, silent = true })
		end,
	},
	{

		"jtdowney/vimux-cargo",

		config = function()
			vim.api.nvim_set_keymap("n", "<leader>cr", ":wa<CR> :CargoRun<CR>", { noremap = true, silent = true })
		end,
	},
}
