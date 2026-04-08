return {
	{
		"nvim-telescope/telescope.nvim",
		version = '*',
		dependencies = { "nvim-lua/plenary.nvim",
			-- optional but recommended
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require('telescope').setup {
				extensions = {
					fzf = {
						case_mode = "smart_case", -- or "smart_case", "respect_case"
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				}
			}
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("fzf")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
		end,
	},
}
