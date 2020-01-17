####### Custom Aliases #################################

alias lt="ls -lrtF"
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
alias le='$(fc -ln -1)'
alias jupremote="jupyter --no-browser --port=8889"
alias evim="v ~/.vimrc"
alias etmux="v ~/.tmux.conf"
alias ebash="v ~/dotfiles/bashrc"
alias sbash="source ~/.bashrc"
alias jup2html="jupyter nbconvert --to html_embed"
# ripgrep throws errors for ** wildcards in .gitignore, therefore hide errors
alias rg="rg -p 2> /dev/null"
alias shortprompt="PROMPT_DIRTRIM=1"
alias longprompt="PROMPT_DIRTRIM=3"
alias fullprompt="PROMPT_DIRTRIM=0"


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# VIM Editor Default
#export VISUAL=vim
#export EDITOR="$VISUAL"
bind '"jk":vi-movement-mode'

export TERM=xterm-256color

# Function to print out all 256 colors to the terminal
print_colors(){
    for i in {0..255} ; do
        printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
        if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
            printf "\n";
        fi
    done
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Matlab like history retrieval
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# Delete text to the right of cursor
#bind '"\C-i":kill-line'

# Set terminal tab title
tt(){
       echo -en "\033]0;$1\a"
}


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -Ax'
alias l='ls -CFx'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'



###########  Infinite bash history   ###################################
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#  (from wiki computer_setup/linux/bashrc)
# source ~/.infinite-bash-history.sh

# Author: Joseph Lisee

# Usage: either copy this directly into your ~/.bashrc, or source it from your
# bashrc like so:
#
#     source infinite-bash-history.sh

# Make sure the history directory exists
if [ ! -d $HOME/.history-bash ]; then
    mkdir -p $HOME/.history-bash
fi

# Save your history week-by-week
export HISTFILE=$HOME/.history-bash/"hist-`date +%Y-%W`.hist"
if [[ ! -f $HISTFILE ]]; then
    # We're starting a new history file. Find the previous (biggest date) histfile
    LASTHIST=~/.history-bash/`ls -1tr ~/.history-bash/ | tail -1`;
    if [[ -f "$LASTHIST" ]]; then
        # and stock our new history with the last 500 lines of last week's file
        tail -500 "$LASTHIST" > $HISTFILE
        # Write a divider to identify where the prior day's session history ends
        echo "####### `date +%Y-%W-%w` : `date` #######" >> $HISTFILE
    fi
fi

export HISTSIZE=100000
# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth
# don't limit the size of the history file.
unset HISTFILESIZE

# Here are some perhaps helpful commands to accompany those
# command to pull in the contents of the history file (good for pulling history
# from one terminal to the next)
alias histup='history -n $HISTFILE'

# search (using perl regexp syntax) your entire history this also
# assumes you have history from other machines in subdirectories. The
# python script strips out the machine specific dir, then sorts
# everything together in a stable manner.
function histgrep()
{
    cd ~/.history-bash
    grep -P -r "$@" . | python <(cat <<HERE
import sys
for line in sys.stdin:
    parts = line.split(':')
    file = parts[0]
    fparts = file.split('/')
    print ':'.join([fparts[-1]] + parts[1:]),
HERE
    ) | sort --stable --key=1.1,1.13 | cut -d ':' -f 2-
    cd - > /dev/null
}

# use rsync to pull history from a specific machine
function pullhist()
{
    # Note the "a_" is to make sure the results come first
    local remote_host=$1
    rsync -av --progress $remote_host:~/.history-bash/ ~/.history-bash/a_$remote_host/
}

# Usage 
#  CTRL-R - This is the normal bash history search command, it still works, 
#           only better because you are saving more history.
#  histgrep - Search all the archived history (stored in ~/.history-bash) 
#  pullhist - rsync history from on machine to another (stored in ~/.history-bash/a_<remote_host>)
#  histup - update the current shell with the history file on disk, makes it easy 
#           to move history between active terminals





########### Prompt with Git #################################

# Trim parent directories in pwd above specified trim depth with \w
export PROMPT_DIRTRIM=3
# Abbreviate parent directories to first letter with $PS1_PATH
#PROMPT_COMMAND='PS1_PATH=$(sed "s:\([^/\.]\)[^/]*/:\1/:g" <<< ${PWD/#$HOME/\~})'

PS1='\[\033[01;32m\][\t]\[\033[01;34m\]\w\[\033[00m\]\[\033[00m\]:> '

# Show git branch in terminal (from wiki computer_setup/linux/bashrc)
# Custom GIT PS1 function
function local_git_ps1 ()
{
    # This code drops the trailing space
    local prompt
    prompt=$(__git_ps1)
    short_prompt=${prompt:1}

    echo -e $short_prompt
}

# If we have the git_ps1 helper use it
if command -v __git_ps1 >/dev/null 2>&1  ; then

    # Define the options for the git PS1
    # WARNING: enabling some of these options can cause performance issues
    # on large repositories, leading to sluggish shell use.
    #GIT_PS1_SHOWDIRTYSTATE="y"
    #GIT_PS1_SHOWSTASHSTATE="y"
    #GIT_PS1_SHOWUNTRACKEDFILES="y"
    #GIT_PS1_SHOWUPSTREAM="verbose"

    # Update the standard Ubuntu PS1 with git information.
    PS1='\[\033[01;32m\][\t]\[\033[01;34m\]\w\[\033[00m\]\[\033[00m\]:$(local_git_ps1)> '
    #PS1='\[\033[01;32m\][\t]\[\033[01;34m\]$PS1_PATH\[\033[00m\]\[\033[00m\]:$(local_git_ps1)> '
fi


##################   FZF  #################################
# FZF
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND='fd --type f'
export FZF_ALT_C_COMMAND='fd --type d'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# Re-bind ALT-C to Ctrl-o
# bind "$(bind -s | grep '^"\\ec"' | sed 's/\\ec/\\C-o/')"

export FZF_DEFAULT_OPTS='
    --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
    --color info:150,prompt:110,spinner:150,pointer:167,marker:174
'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}


# FZF autocomplete settings (compatible commands and trigger)
complete -F _fzf_path_completion -o default -o bashdefault v
complete -F _fzf_path_completion -o default -o bashdefault grab
export FZF_COMPLETION_TRIGGER='**'


#################### FZF Functions #######################################

# Ctrl-P  Open file in VIM
#bind -x '"\C-p": </dev/tty vim $(fzf -m --height 40% --reverse --preview="coderay {}")'
bind -x '"\C-p": nvim $(fzf -m --height 40% --reverse --preview="coderay {}")'
#bind -x '"\C-p": vim -c ":Files"'
# Other defaults:
#     alt-c: cd to directory with fzf


# v - open recent files from ~/.viminfo
vv() {
  local files
  files=$(grep '^>' ~/.viminfo | cut -c3- |
          while read line; do
            [ -f "${line/\~/$HOME}" ] && echo "$line"
          done | fzf-tmux -d -m -q "$*" -1) && vim ${files//\~/$HOME}
}


# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --pretty=format:'%C(bold red)%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' \
      --abbrev-commit --date=relative --branches=* |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --header "Press CTRL-S to toggle sort" \
      --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                 xargs -I % sh -c 'git show --color=always % | head -$LINES'" \
      --bind "enter:execute:echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
              xargs -I % sh -c 'vim fugitive://\$(git rev-parse --show-toplevel)/.git//% < /dev/tty'"
}


# fco_preview - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
fco_preview() {
  local tags branches target
  tags=$(
git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
git branch --all | grep -v HEAD |
sed "s/.* //" | sed "s#remotes/[^/]*/##" |
sort -u | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
(echo "$tags"; echo "$branches") |
    fzf --no-hscroll --no-multi --delimiter="\t" -n 2 \
        --ansi --preview="git log -200 --pretty=format:%s $(echo {+2..} |  sed 's/$/../' )" ) || return
  git checkout $(echo "$target" | awk '{print $2}')
}


# gco - checkout git branch
gco() {
  local branch
  branch=$(script -q /dev/null -c "git branch" < /dev/null | fzf +m --ansi --reverse --height=40% \
    --preview='(git show --summary --color=always {+1} | head -6 && git show --stat --oneline --color=always {+1} | tail -n +2 \
                || git show --summary --color=always {+2} | head -6 && git show --stat --oneline --color=always {+2} | tail -n +2)\
                2> /dev/null' --preview-window right:40%)
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}
# Arc version:  branch=$(script -q /dev/null -c "arc branch --view-all" < /dev/null | fzf +m --ansi --reverse --height=40% \


###############  BASH Functions  ###################################

# ripgrep inside vim
rgg() {
  nvim -c "F $1"
}

# Autojump
j() {
    if [[ "$#" -ne 0 ]]; then
        cd $(autojump $@)
        return
    fi
    cd "$(autojump -s | sed '/_____/Q; s/^[0-9,.:]*\s*//' |  fzf --height 40% --nth 1.. --reverse --inline-info +s --tac --query "${*##-* }" )"
}

# Bash grab dump (copy paste files via CLI)
grab(){
    rm -f ~/.grab/*
    echo "Grabbed:"
    for i in $*
    do
        cp -d $i ~/.grab/
        echo $i
    done }
#alias dump="ls -d /tmp/ccopy* | sed 's|[^\.]*.\.||' | xargs -I % mv /tmp/ccopy.% ./%"
alias dump="mv ~/.grab/* ."


########### ssh-agent setup Method 2     ################################
#
#if [ ! -S ~/.ssh/ssh_auth_sock ]; then
#  eval `ssh-agent`
#    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
#fi
#export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
#ssh-add -l | grep "The agent has no identities" && ssh-add
#

################## TMUX #############################
# # Start TMUX if it is not already running
# if [[ -z "$TMUX" ]]; then
#     tmux attach -t base || tmux new -s base
# fi



######## Prequisites for some functions ##############
for prereq in fzf fd rg xclip coderay; do
    if [ -z `which $prereq` ]; then
        echo "Warning: $prereq not installed"
    fi
done


