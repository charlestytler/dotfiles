
# Ctrl-p Open files into neovim
function open_files_in_nvim
  nvim $(fzf -m --reverse --preview="bat --color=always --style=numbers --line-range=:500 {}")
end

