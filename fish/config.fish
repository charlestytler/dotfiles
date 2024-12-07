if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting

######### VIM-Mode KEYBINDS #################
set -g fish_key_bindings fish_vi_key_bindings
# This binds "jk" to switch to normal mode in vi-mode.
# If you kept it like that, every time you press "j",
# fish would wait for a "k" or other key to disambiguate
bind -M insert -m default jk cancel repaint-mode

# After setting this, fish only waits 200ms for the "k",
# or decides to treat the "j" as a separate sequence, inserting it.
set -g fish_sequence_key_delay_ms 200

set -g fish_vi_force_cursor 1
set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_visual block
set -g fish_cursor_replace_one underscore
set -g fish_cursor_replace underscore

function fish_user_key_bindings
    for mode in insert default visual
        # This binds Ctrl-Space to accept a fish autocomplete suggestion (same as right-arrow).
        bind -M $mode -k nul forward-char
    end
end

####### Custom Aliases #################################

alias c="z"
#alias lt="ls -lrtF"
#alias la="ls -lrtFA"
alias ls="eza --icons=always"
alias lt="eza --icons=always -l -s modified"
alias la="eza --icons=always -la -s modified"
alias u="cd .."
alias uu="cd ../.."
alias uuu="cd ../../.."
alias uuuu="cd ../../../.."

alias v="nvim"
alias vi="nvim" # Cause I still do this out of habit
alias vgit="v \`git sh | tail -n +2\`"
alias gitlog="git lg1 | head -10"
alias gitclear="git reset --hard; git clean -i"
alias gitcount="git diff --cached --numstat | wc -l"
alias gitclidiff="export $GIT_EXTERNAL_DIFF=diffy"
alias jupremote="jupyter --no-browser --port=8889"
alias evim="v ~/.vimrc"
alias etmux="v ~/.tmux.conf"
alias ebash="v ~/dotfiles/bashrc"
alias sbash="source ~/.bashrc"
alias jup2html="jupyter nbconvert --to html_embed"

# Protection against pushing master
function gpo --wraps='git po' --description 'alias gph git ph'
  set -l branch (git rev-parse --abbrev-ref HEAD)

  set -l protected "master" "main"
  if contains $branch $protected
    echo "Protected branch $branch. Skipping push."
    return 1
  end
  git push origin $argv
end


##### STARSHIP PROMPT ###########
starship init fish | source
# enable_transience

# Zoxide (smart cd)
zoxide init fish --cmd cd | source

# NPM 
# requires "fisher install jorgebucaran/nvm.fish"
set -xU nvm_default_version 22

########## FZF ######################

# Ctrl-p Open files into neovim
function open_files_in_nvim
  nvim $(fzf -m --reverse --preview="bat --color=always --style=numbers --line-range=:500 {}")
end

# gco - git checkout branch
function git_br_preview_win_width
  set screen_width $(tput cols)
  set max_branch_width $(git branch | wc -L)
  math $screen_width - $max_branch_width - 10
end
alias gco='git checkout $(git branch --sort=-committerdate --format "%(refname:short)" | \
  fzf --height=40% --reverse --ansi \
  --preview="git tree" \
  --preview-window=right,$(git_br_preview_win_width))'

###### BINDINGS ####################
function fish_user_key_bindings
  bind -M insert -k nul forward-char
  bind -M insert \cp open_files_in_nvim
end
