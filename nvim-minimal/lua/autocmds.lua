-- Save last cursor position in buffer
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	desc = "return cursor to where it was last time closing the file",
	pattern = "*",
	nested = true,
	command = 'silent! normal! g`"zv',
})
