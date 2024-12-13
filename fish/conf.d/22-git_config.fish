alias vgit="nvim \`git sh | tail -n +2\`"
alias gitlog="git lg1 | head -10"
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
  --preview="git tree --highlight {}" \
  --preview-window=right,$(git_br_preview_win_width))'

# gpo - Protection against pushing master
function gpo --wraps='git po' --description 'alias gph git ph'
  set -l branch (git rev-parse --abbrev-ref HEAD)

  set -l protected "master" "main"
  if contains $branch $protected
    echo "Protected branch $branch. Skipping push."
    return 1
  end
  git push origin $argv
end
