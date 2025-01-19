# #!/usr/bin/env bash

# Note: executed at end of file where it accepts "$@"
run() {
  # Check if running script from correct directory
  if [ ! -f ./install.sh ] || [ ! -f ./installConfig.cfg ]; then
    echo "Please run this script from the dotfiles directory"
    exit 1
  fi
  DOTFILES_DIR=$(pwd) # Global variable allowed for use in installConfig.cfg

  source _installFns/parseArgs.sh          # Import parseArgs
  source _installFns/parseConfig.sh        # Import parseConfigForSectionsPkgsCommands
  source _installFns/promptToContinue.sh   # Import promptToContinue
  source _installFns/installMissingPkgs.sh # Import installMissingPkgs

  # Mutable arrays populated by parseConfigForSectionsPkgsCommands
  declare -a CONFIG_sections
  declare -a CONFIG_pkgs
  declare -a CONFIG_commands
  parseConfigForSectionsPkgsCommands "./installConfig.cfg" # Only care about sections on this parse
  filtered_sections=$(parseArgs "${CONFIG_sections[*]}" "$@")

  printf "Installing dotfiles...\n\nSections to install:\n"
  echo "  $filtered_sections"
  if ! promptToContinue "Do you want to install dotfiles for these applications? (y/n) "; then
    echo "Re-run script with --include/-i or --exclude/-e flags to modify sections to install"
    exit 0
  fi

  # Rerun parsing to get pkgs and commands for filtered sections
  # This could be avoided by using associative arrays, but that would require bash 4.0
  CONFIG_pkgs=()     # Reset CONFIG_pkgs array
  CONFIG_commands=() # Reset CONFIG_commands array
  parseConfigForSectionsPkgsCommands "./installConfig.cfg" "$(detectOS)" "$filtered_sections"

  # Install any missing packages
  echo
  installMissingPkgs "${CONFIG_pkgs[*]}"

  # Execute all commands parsed from config file
  printf "\nDotfiles installation...\n"
  for cmd in "${CONFIG_commands[@]}"; do
    eval "$cmd"
  done
}

detectOS() {
  local os
  os=$(uname)
  case "$os" in
  Darwin) echo "MAC" ;;
  Linux) echo "LINUX" ;;
  MINGW*) echo "WIN" ;;
  *) echo "Unsupported OS: $os" && exit 1 ;;
  esac
}

# Execute script
run "$@"
