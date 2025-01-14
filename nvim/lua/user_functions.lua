-- Save last cursor position in buffer
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  -- group = "userconfig",
  desc = "return cursor to where it was last time closing the file",
  pattern = "*",
  command = 'silent! normal! g`"zvzz',
})

-- Create a new scratch buffer
vim.api.nvim_create_user_command("Scratch", function()
  vim.cmd [[
		execute 'vsplit | enew'
		setlocal buftype=nofile
		setlocal bufhidden=hide
		setlocal noswapfile
	]]
end, { nargs = 0 })

-- Compare clipboard to current buffer
vim.api.nvim_create_user_command("CompareClipboard", function()
  local ftype = vim.api.nvim_eval "&filetype" -- original filetype
  vim.cmd [[
		tabnew %
		execute 'vsplit | enew'
		setlocal buftype=nofile
		setlocal bufhidden=hide
		setlocal noswapfile
		normal! P
		windo diffthis
	]]
  vim.cmd("set filetype=" .. ftype)
end, { nargs = 0 })
vim.keymap.set("n", "<leader>dp", "<cmd>CompareClipboard<cr>", { desc = " Diff against Clipboard" })

vim.api.nvim_create_user_command("CompareClipboardSelection", function()
  vim.cmd [[
		" yank visual selection to z register
		normal! gv"zy
		" open new tab, set options to prevent save prompt when closing
		execute 'tabnew | setlocal buftype=nofile bufhidden=hide noswapfile'
		" paste z register into new buffer
		normal! V"zp
		Ns
		normal! Vp
		windo diffthis
	]]
end, {
  nargs = 0,
  range = true,
})
vim.keymap.set("v", "<leader>dp", "<cmd>CompareClipboard<cr>", { desc = " Diff against Clipboard" })
