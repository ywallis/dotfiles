vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.opt.relativenumber = true

local argv = vim.fn.argv()
local file = argv[1] or ""
local is_git_edit = file:match("COMMIT_EDITMSG") or file:match("MERGE_MSG") or file:match("git%-rebase%-todo")

if not is_git_edit then
  local session_file = vim.fn.getcwd() .. "/Session.vim"
  if vim.fn.filereadable(session_file) == 1 then
    vim.cmd("source " .. session_file)
  end
end
