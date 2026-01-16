# For using git in WSL and Windows
function git --description 'Use git.exe on Windows mounts and linux git elsewhere'
    # Check if the current directory starts with /mnt/c/ or /mnt/d/
    if string match -q "/mnt/c/*" (pwd); or string match -q "/mnt/d/*" (pwd)
        git.exe $argv
    else
        # 'command git' ensures we call the binary, not the function itself (prevents recursion)
        command git $argv
    end
end


alias vgit="nvim \`git sh | tail -n +2\`"
alias gitlog="git lg1 --color=always | head -10"
alias gitlg="git lg --color=always | head -15"
alias gitclear="git reset --hard; git clean -i"
alias gitcount="git diff --cached --numstat | wc -l"
alias gitclidiff="export $GIT_EXTERNAL_DIFF=diffy"

# gco - git checkout branch
function git_br_preview_win_width
  set screen_width $(tput cols)
  set max_branch_width $(git branch | wc -L)
  math $screen_width - $max_branch_width - 10
end
alias gco='git checkout $(git branch --sort=-committerdate --format "%(refname:short)" | \
  fzf --height=40% --reverse --ansi \
  --preview="git tree --concise --highlight {}" \
  --preview-window=right,$(git_br_preview_win_width))'

alias gpo='git push origin'
