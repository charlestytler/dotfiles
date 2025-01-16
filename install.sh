# Custom path definitions
if [[ "$(uname)" = "Darwin" ]]; then
  VSCODE_PATH="$HOME/Library/Application\ Support/Code/User"
elif [[ "$(uname)" = "MINGW"* ]]; then
  VSCODE_PATH="%APPDATA%/Code/User"
else
  VSCODE_PATH="$HOME/.config/Code/User"
fi

# Config installation steps
declare -A installScript
DOTFILES_DIR="$HOME/dotfiles"

installScript["vim"]="\
  safeSymlink $DOTFILES_DIR/vim/vimrc $HOME/.vimrc"

installScript["nvim"]="\
  safeSymlink $DOTFILES_DIR/nvim $HOME/.config/nvim"

installScript["tmux"]="\
  safeSymlink $DOTFILES_DIR/tmux $HOME/.config/tmux"

installScript["starship"]="\
  safeSymlink $DOTFILES_DIR/starship/starship.toml $HOME/.config/starship.toml"

installScript["vscode"]="\
  safeSymlink $DOTFILES_DIR/vscode/settings.json $VSCODE_PATH/settings.json; \
  safeSymlink $DOTFILES_DIR/vscode/keybindings.json $VSCODE_PATH/keybindings.json"

### End of user configuration ###

# Note: executed at end of file.
run() {
  # Check if running script from correct directory
  if [ ! -f ./install.sh ]; then
    echo "Please run this script from the dotfiles directory"
    exit 1
  fi

  echo "Installing dotfiles..."
  for program in "${!installScript[@]}"; do
    echo "$program:"
    ${installScript[$program]}
  done

  # safeSymlink vim ~/dotfiles/vim/vimrc ~/.vimrc
  # safeSymlink nvim ~/dotfiles/nvim ~/.config/nvim
  # safeSymlink tmux ~/dotfiles/tmux ~/.config/tmux
  # safeSymlink starship ~/dotfiles/starship/starship.toml ~/.config/starship.toml
  # # echo "source ~/dotfiles/bash/bashrc" >>~/.bashrc
  # # fish -c exit && cp ~/dotfiles/fish/config.fish.sample ~/dotfiles/fish/config.fish && ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish && ln -s ~/dotfiles/fish/conf.d ~/.config/fish/conf.d
  # # echo -e "[include]\n    path = ~/dotfiles/git/gitconfig" >>~/.gitconfig
  # #
  # if [[ "$(uname)" = "Darwin" ]]; then
  #   VSCODE_PATH="$HOME/Library/Application\ Support/Code/User/"
  # elif [[ "$(uname)" = "MINGW"* ]]; then
  #   VSCODE_PATH="%APPDATA%\Code\User\settings.json"
  # else
  #   VSCODE_PATH="$HOME/.config/Code/User/"
  # fi
  # safeSymlink vscode.settings ~/dotfiles/vscode/settings.json "$VSCODE_PATH"/
  # safeSymlink vscode.keys ~/dotfiles/vscode/keybindings.json "$VSCODE_PATH"/

}

safeSymlink() {
  local source=$1
  local target=$2

  checkSymlinkTargetStatus "${target}"
  local targetStatus=$?
  echo "🪵 [install.sh:73] targetStatus: ${targetStatus}"
  case "$targetStatus" in
  0) # nothing exists at target
    ln -s "${source}" "${target}"
    echo "    ${target}: installed"
    ;;
  1) # symlink already exists
    if [ "$(readlink "${target}")" = "${source}" ]; then
      echo "    ${target}: skipped... link already exists"
    else
      echo "    Link exists but points to different location:"
      echo "      $(readlink "${target}")"
      overwriteWithUserPermission "${target}" "${target}" "${source}"
    fi
    ;;
  2)
    echo "    ${target}: not installed... broken link exists"
    ls -l "${target}"
    overwriteWithUserPermission "${target}" "${target}" "${source}"
    ;;
  3)
    echo "    ${target}: not installed... config file exists"
    overwriteWithUserPermission "${target}" "${target}" "${source}"
    ;;
  4)
    echo "    ${target}: not installed... directory exists"
    overwriteWithUserPermission "${target}" "${target}" "${source}"
    ;;
  5)
    echo "    ${target}: not installed... parent directory does not exist"
    echo "    Make sure ${target} is properly installed first"
    ;;
  esac
}

overwriteWithUserPermission() {
  local name=$1
  local target=$2
  local source=$3
  promptToContinue && ln -sf "${source}" "${target}" || echo "    ${name}: skipped"
}

promptToContinue() {
  read -p "    Do you want to overwrite this? (y/n) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    return 1
  fi
}

checkSymlinkTargetStatus() {
  local targetLoc=$1

  local targetDir
  targetDir=$(dirname "${targetLoc}")
  echo "targetDir: ${targetDir}"
  if [ ! -d "${targetDir}" ]; then
    # "Parent directory does not exist"
    return 5 # false
  fi

  if [ -L "${targetLoc}" ]; then
    if [ -e "${targetLoc}" ]; then
      # "Good link already exists"
      return 1 # false
    else
      # "Link exists, but is broken"
      return 2 # false
    fi
  elif [ -f "${targetLoc}" ]; then
    # "File exists and is not a link"
    return 3 # false
  elif [ -d "${targetLoc}" ]; then
    # "Directory exists and is not a link"
    return 4 # false
  else
    # "No file or link exists"
    return 0 # true
  fi
}

run "$@"
