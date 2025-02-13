-- Removed import and pasted in mappings from commit f6025f0788880989484733c90deff07dff01ef02 below
-- https://github.com/NvChad/NvChad/blob/bbc3d43db088c141b142a40cd5f717635833a54e/lua/nvchad/mappings.lua

-- require "nvchad.mappings"

local map = vim.keymap.set

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

--map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
--map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
--map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
--map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

-- map("n", "<leader>ul", "<cmd>set nu!<CR>", { desc = "UI toggle line number" })
map("n", "<leader>ur", "<cmd>set rnu!<CR>", { desc = "UI toggle relative number" })
map("n", "<leader>uc", "<cmd>NvCheatsheet<CR>", { desc = "UI toggle nvcheatsheet" })

map("n", "<leader>cf", function()
  require("conform").format { lsp_fallback = false }
end, { desc = "code format file" })

-- global lsp mappings
-- map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

-- tabufline
-- map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "buffer new" })

--map("n", "<tab>", function()
--  require("nvchad.tabufline").next()
--end, { desc = "buffer goto next" })
--
--map("n", "<S-tab>", function()
--  require("nvchad.tabufline").prev()
--end, { desc = "buffer goto prev" })

-- map("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "buffer close" })

-- Comment
map("n", "<leader>'", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>'", "gc", { desc = "toggle comment", remap = true })

-- nvimtree
-- map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
-- map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- telescope
-- map("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Open File" })
-- map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files (cwd)" })
-- map("n", "<leader>fr", "<cmd>Telescope find_files<cr>", { desc = "Find files (repo)" })
-- map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
-- map("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "Find marks" })
-- map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Find oldfiles" })
-- map("n", "<leader>f:", "<cmd>Telescope commands<CR>", { desc = "Find commands" })
-- map("n", "<leader>fp", "<cmd>Telescope commands<CR>", { desc = "Find paste register" })
-- map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find keybindings " })
-- map(
--   "n",
--   "<leader>fc",
--   "<cmd>Telescope find_files cwd=$HOME/.config/nvim follow=true no_ignore=true hidden=true<CR>",
--   { desc = "Find config files" }
-- )

-- map("n", "<leader>sf", "<cmd>Telescope live_grep<CR>", { desc = "Search files" })
-- map({ "n", "v" }, "<leader>sg", "<cmd>Telescope grep_string<CR>", { desc = "Search grep under cursor" })
-- map("n", "<leader>s/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Search in current file" })
-- map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "Search help" })
map("n", "<leader>sc", "<cmd>Telescope live_grep cwd=$HOME/.config/nvim<CR>", { desc = "Search config files" })
--
-- map("n", "<leader>gc", "<cmd>Telescope git_bcommits<CR>", { desc = "git commits" })
-- map("v", "<leader>gc", "<cmd>Telescope git_bcommits_range<CR>", { desc = "git commits" })
-- map("n", "<leader>gd", "<cmd>Telescope git_status<CR>", { desc = "git diff" })
-- map("n", "<leader>gt", "<cmd>Telescope git_stash<CR>", { desc = "git stash" })
--
-- map("n", "<leader>cq", "<cmd>Telescope quickfix<CR>", { desc = "Code quickfix" })

-- map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })

map("n", "<leader>ut", function()
  require("nvchad.themes").open()
end, { desc = "UI choose nvchad themes" })

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- new terminals
--map("n", "<leader>h", function()
--  require("nvchad.term").new { pos = "sp" }
--end, { desc = "terminal new horizontal term" })
--
--map("n", "<leader>v", function()
--  require("nvchad.term").new { pos = "vsp" }
--end, { desc = "terminal new vertical term" })

-- toggleable
-- map({ "n", "t" }, "<A-v>", function()
--   require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
-- end, { desc = "terminal toggleable vertical term" })

-- map({ "n", "t" }, "<A-h>", function()
--   require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
-- end, { desc = "terminal toggleable horizontal term" })

map({ "n", "t" }, "<C-\\>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

-- whichkey
-- map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })
--
-- map("n", "<leader>wk", function()
--   vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
-- end, { desc = "whichkey query lookup" })

-- add yours here

-- remove specific NvChad default mappings
--local nomap = vim.keymap.del

--nomap("n", "<leader>fw")
