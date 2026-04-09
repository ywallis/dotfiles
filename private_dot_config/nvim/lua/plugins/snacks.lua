return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		image = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		lazygit = { enabled = true },
		notifier = { enabled = true },
		notify = { enabled = true },
		picker = { enabled = true },
		-- statuscolumn = { enabled = true },
		-- words = { enabled = true },
	},
	keys = {
		{ "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
		{ "<leader>gg", function() Snacks.lazygit() end,               desc = "Lazygit" },
		{ "<leader>un", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
	},
}
