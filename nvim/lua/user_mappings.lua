local map = vim.keymap.set

-- Keybinds I can't function without
map("i", "jk", "<ESC>", { noremap = true, desc = "Return to normal mode" })
map("n", "Q", "<Cmd>qall!<CR>", { noremap = true, desc = "Quit w/o Saving" })

vim.g.mapleader = " "

-- File Buffer Navigation
map({ "n", "v" }, "(", "<cmd> bp <cr>", { desc = "Buffer Prev" })
map({ "n", "v" }, ")", "<cmd> bn <cr>", { desc = "Buffer Next" })

-- Tmux/vim Window Navigation
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { noremap = true, desc = "Window Select " })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { noremap = true, desc = "Window Select " })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { noremap = true, desc = "Window Select " })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { noremap = true, desc = "Window Select " })
-- (vim) Window Splits
map("n", "<leader>wh", "<cmd>leftabove vsplit<cr>", { noremap = true, desc = "Window Split " })
map("n", "<leader>wj", "<cmd>rightbelow split<cr>", { noremap = true, desc = "Window Split " })
map("n", "<leader>wk", "<cmd>leftabove split<cr>", { noremap = true, desc = "Window Split " })
map("n", "<leader>wl", "<cmd>rightbelow vsplit<cr>", { noremap = true, desc = "Window Split " })

-- Window Resizing
map("n", "<C-]>", "<cmd>vertical resize +15<cr>", { noremap = false, desc = "Window Width +" })
map("n", "<C-[", "<cmd>vertical resize -15<cr>", { noremap = false, desc = "Window Width +" })

map("n", "<leader>w]", "<cmd>vertical resize +15<cr>", { noremap = false, desc = "Window Width +" })
map("n", "<leader>w[", "<cmd>vertical resize -15<cr>", { noremap = false, desc = "Window Width +" })
map("n", "<leader>w.", "<cmd>resize +15<cr>", { noremap = false, desc = "Window Height +" })
map("n", "<leader>w,", "<cmd>resize -15<cr>", { noremap = false, desc = "Window Height +" })

map("n", "<leader>w}", "<cmd>vertical resize +10<cr>", { noremap = false, desc = "Window Width +" })
map("n", "<leader>w{", "<cmd>vertical resize -10<cr>", { noremap = false, desc = "Window Width -" })
map("n", "<leader>w>", "<cmd>resize +10<cr>", { noremap = false, desc = "Window Height +" })
map("n", "<leader>w<", "<cmd>resize -10<cr>", { noremap = false, desc = "Window Height -" })

map("n", "<leader>w=", "<C-w>=", { noremap = false, desc = "Window size equal" })
map({ "n", "v" }, "<leader>wq", "<C-w>q", { noremap = false, desc = "Window close" })
map("n", "<leader>w<CR>", ":tab split<CR>", { noremap = false, desc = "Window maximize (tab)" })

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
vim.keymap.set("x", ";p", [["_dP]], { desc = "Register-hold Paste" })
vim.keymap.set({ "n", "v" }, ";y", [["+y]], { desc = "Clipboard- yank" })
vim.keymap.set("n", ";Y", [["+Y]], { desc = "Clipboard- yank line" })
vim.keymap.set({ "n", "v" }, ";d", '"_d', { desc = "Register-hold Delete" })

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
