local map = vim.keymap.set

-- Keybinds I can't function without
map("i", "jk", "<ESC>", { noremap = true, desc = "Return to normal mode" })
map("n", "Q", "<Cmd>qall!<CR>", { noremap = true, desc = "Quit w/o Saving" })

vim.g.mapleader = " "

-- File Buffer Navigation
map({ "n", "i", "v" }, "(", "<cmd> bp <cr>", { desc = "Buffer Prev" })
map({ "n", "i", "v" }, ")", "<cmd> bn <cr>", { desc = "Buffer Next" })
map({ "n", "i", "v" }, "<tab><BS>", "<cmd>bp|bd #<cr>", { desc = "Buffer Close" })

-- Tmux/vim Window Navigation
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { noremap = true, desc = "Window Select " })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { noremap = true, desc = "Window Select " })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { noremap = true, desc = "Window Select " })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { noremap = true, desc = "Window Select " })
-- (vim) Window Splits
map("n", "<tab>h", "<cmd>leftabove vsplit<cr>", { noremap = true, desc = "Window Split " })
map("n", "<tab>j", "<cmd>rightbelow split<cr>", { noremap = true, desc = "Window Split " })
map("n", "<tab>k", "<cmd>leftabove split<cr>", { noremap = true, desc = "Window Split " })
map("n", "<tab>l", "<cmd>rightbelow vsplit<cr>", { noremap = true, desc = "Window Split " })

-- Movement
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection " })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection " })
vim.keymap.set("n", "s", "<nop>")

-- Cursor movement overrides
--vim.keymap.set("n", "<C-d>", "<C-d>zz", {desc=""})
--vim.keymap.set("n", "<C-u>", "<C-u>zz", {desc=""})
vim.keymap.set("n", "n", "nzzzv", { desc = "󰈞 next" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "󰈞 prev" })

-- Register workarounds
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Register-hold Paste" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Clipboard- yank" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Clipboard- yank line" })
-- vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Register-hold Delete" })

-- Under cursor utilities
vim.keymap.set(
  "n",
  "<leader>r/",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word under cursor" }
)
vim.keymap.set("v", "<leader>r/", 'y:%s/<C-r>"/<C-r>"/gI<Left><Left><Left>', { desc = "Replace selection" })

-- Count
vim.keymap.set({ "n", "v" }, "+", "<C-a>", { desc = "Number Increase" })
vim.keymap.set("v", "<leader>+", "g<C-a>", { desc = "Number Increase sequence" })
vim.keymap.set({ "n", "v" }, "-", "<C-x>", { desc = "Number Decrease" })
vim.keymap.set("v", "<leader>-", "g<C-x>", { desc = "Number Decrease sequence" })
