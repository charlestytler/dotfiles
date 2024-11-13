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


##### STARSHIP PROMPT ###########
starship init fish | source
# enable_transience

# Zoxide (smart cd)
zoxide init fish --cmd cd | source
