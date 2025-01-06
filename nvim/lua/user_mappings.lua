local map = vim.keymap.set

-- Keybinds I can't function without
map("i", "jk", "<ESC>", { noremap = true, desc = "Return to normal mode" })
map("n", "Q", "<Cmd>qall!<CR>", { noremap = true, desc = "Quit w/o Saving" })

vim.g.mapleader = " "

-- Macro override (to prevent accidental presses, require <leader>q)
map("n", "<leader>q", "q", { noremap = true, desc = "Macro" })
map("n", "q", "<Nop>")

-- File Buffer Navigation -- disabled due to buffer_manager.lua
-- map({ "n", "v" }, "(", "<cmd> bp <cr>", { desc = "Buffer Prev" })
-- map({ "n", "v" }, ")", "<cmd> bn <cr>", { desc = "Buffer Next" })

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
map("n", "<C-[", "<cmd>vertical resize -15<cr>", { noremap = false, desc = "Window Width -" })

map("n", "<leader>ww", "<cmd>vertical resize +15<cr>", { noremap = false, desc = "[W]ide Window Width +" })
map("n", "<leader>wn", "<cmd>vertical resize -15<cr>", { noremap = false, desc = "[N]arrow Window Width -" })
map("n", "<leader>wt", "<cmd>resize +15<cr>", { noremap = false, desc = "[T]all Window Height +" })
map("n", "<leader>ws", "<cmd>resize -15<cr>", { noremap = false, desc = "[S]hort Window Height -" })

map("n", "<leader>w<right>", "<cmd>vertical resize +10<cr>", { noremap = false, desc = "Window Width +" })
map("n", "<leader>w<left>", "<cmd>vertical resize -10<cr>", { noremap = false, desc = "Window Width -" })
map("n", "<leader>w<up>", "<cmd>resize +10<cr>", { noremap = false, desc = "Window Height +" })
map("n", "<leader>w<down>", "<cmd>resize -10<cr>", { noremap = false, desc = "Window Height -" })

map("n", "<leader>we", "<C-w>=", { noremap = false, desc = "[E]qual Window size" })
map("n", "<leader>wo", "<C-w>o", { noremap = false, desc = "[O]nly this Window" })
map({ "n", "v" }, "<leader>wq", "<C-w>q", { noremap = false, desc = "[Q]uit Window" })
map("n", "<leader>w<CR>", "<C-w>|<C-w>_", { noremap = false, desc = "Window maximize" })
map("n", "<leader>wT", ":tab split<CR>", { noremap = false, desc = "Open in new [T]ab" })

-- Movement
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection " })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection " })
vim.keymap.set("n", "s", "<nop>")

-- Cursor movement overrides
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "" })
-- vim.keymap.set("n", "n", "nzzzv", { desc = "󰈞 next" })
-- vim.keymap.set("n", "N", "Nzzzv", { desc = "󰈞 prev" })

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
