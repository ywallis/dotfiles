vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.opt.relativenumber = true

local session_file = vim.fn.getcwd() .. "/Session.vim"
if vim.fn.filereadable(session_file) == 1 then
  vim.cmd("source " .. session_file)
end

