-- disable nvim intro
vim.opt.shortmess:append("sI")

vim.opt.cmdheight = 0
vim.opt.laststatus = 2

vim.opt.number = true
vim.opt.relativenumber = true

-- vim.opt.tabstop = 4
-- vim.opt.softtabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.timeoutlen = 400
-- interval for writing swap file to disk, also used by gitsigns
vim.opt.updatetime = 250

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 3

vim.opt.fillchars = {
	diff = "/",
}

-- For GUIs such as Neovide
vim.opt.guifont = "Hack_Nerd_Font:h10"
