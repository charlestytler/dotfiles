# #!/usr/bin/env bash

# Note: executed at end of file.
run() {
  # Check if running script from correct directory
  if [ ! -f ./install.sh ] || [ ! -f ./installConfig.cfg ]; then
    echo "Please run this script from the dotfiles directory"
    exit 1
  fi
  DOTFILES_DIR=$(pwd) # Global variable allowed for use in installConfig.cfg

  # Define color codes
  local RED='\033[0;31m'
  local GREEN='\033[0;32m'
  local YELLOW='\033[1;33m'
  local ORANGE='\033[0;33m'
  local RESET='\033[0m' # No Color

  # Mutable arrays populated by parseConfigForSectionsPkgsCommands
  declare -a CONFIG_sections
  declare -a CONFIG_pkgs
  declare -a CONFIG_commands
  parseConfigForSectionsPkgsCommands "./installConfig.cfg" # Only care about sections on this parse
  filtered_sections=$(parseArgs "${CONFIG_sections[*]}" "$@")

  echo -e "Installing dotfiles...\n\nSections to install:"
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
  echo -e "\nDotfiles installation..."
  for cmd in "${CONFIG_commands[@]}"; do
    eval "$cmd"
  done
}

show_help() {
  echo "Usage: $0 [options]"
  echo
  echo "Default behavior is to install all sections specified in installConfig.cfg"
  echo
  echo "Options:"
  echo "  --include, -i  Comma-separated list of sections to include"
  echo "  --exclude, -e  Comma-separated list of sections to exclude"
  echo "  --help         Display this help message"
  echo
  echo "Examples:"
  echo "  $0             # Install all sections"
  echo "  $0 -i vim,git  # Install only vim and git sections"
  echo "  $0 -e pkgs     # Install all sections except pkgs"
}

parseArgs() {
  local sections="$1"
  shift

  # Initialize include and exclude lists
  include_sections=()
  exclude_sections=()

  # Parse options
  while [[ "$#" -gt 0 ]]; do
    case $1 in
    --include | -i)
      IFS=',' read -r -a include_sections <<<"$2"
      shift 2
      ;;
    --exclude | -e)
      IFS=',' read -r -a exclude_sections <<<"$2"
      shift 2
      ;;
    --help)
      show_help
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      show_help
      exit 1
      ;;
    esac
  done

  # Filter sections based on include and exclude options
  if [ ${#include_sections[@]} -gt 0 ]; then
    sections=$(echo "$sections" | tr ' ' '\n' | grep -E "$(
      IFS='|'
      echo "${include_sections[*]}"
    )" | tr '\n' ' ')
  fi

  if [ ${#exclude_sections[@]} -gt 0 ]; then
    sections=$(echo "$sections" | tr ' ' '\n' | grep -vE "$(
      IFS='|'
      echo "${exclude_sections[*]}"
    )" | tr '\n' ' ')
  fi

  # Handle case of no sections found
  if [ -z "$sections" ]; then
    echo "No sections found to install, check spelling or --help for instructions"
    exit 0
  fi

  echo "$sections"
}

parseConfigForSectionsPkgsCommands() {
  local cfg_file_path="$1"
  local currentOS="$2"
  local filtered_sections="$3"

  # Variables to track in while loop
  previous_section=""
  current_section=""
  specifiedOS=""

  while IFS= read -r line; do
    # Trim leading and trailing whitespace
    line=$(trim "$line")

    # Ignore empty lines and comments
    if [[ -z "$line" || "$line" =~ ^# ]]; then
      continue
    fi

    # Handle section header lines
    if [[ "$line" =~ ^\[(.*)\]$ ]]; then
      section="${BASH_REMATCH[1]}"
      if [[ "$section" =~ : ]]; then
        current_section="${section%%:*}"
        specifiedOS="${section##*:}"
      else
        current_section="$section"
        specifiedOS=""
      fi

      # Detect section change
      if [[ "$current_section" != "$previous_section" ]]; then
        CONFIG_sections+=("$current_section")
        previous_section="$current_section"

        # Print out header for section actions once per section
        [[ " $filtered_sections " =~ " $current_section " ]] &&
          CONFIG_commands+=("echo -e \"${ORANGE}${current_section}${RESET}:\"")
      fi

      continue
    fi

    # Handle key-value pair lines
    if [[ "$line" =~ ^([^=]+)=(.*)$ ]]; then
      key=$(trim "${BASH_REMATCH[1]}")
      value=$(trim "${BASH_REMATCH[2]}")
      # Ignore if specifiedOS exists and does not equal the currentOS
      [[ -n "$specifiedOS" && "$specifiedOS" != "$currentOS" ]] && continue
      # Skip sections not in the filtered list
      [[ ! " $filtered_sections " =~ " $current_section " ]] && continue

      handleConfigActions "$key" "$value"
    fi
  done <"$cfg_file_path"
}

handleConfigActions() {
  local key="$1"
  local value="$2"

  case "$key" in
  "cmd")
    local success_msg="    ${GREEN}installed:${RESET} cmd successful"
    local failed_msg="    ${RED}failed:${RESET} cmd failed"
    CONFIG_commands+=("$value")
    CONFIG_commands+=("[ $? -eq 0 ] && echo -e \"$success_msg\" || echo -e \"$failed_msg\"")
    ;;
  "include")
    CONFIG_commands+=("safeAppendToFile $value")
    ;;
  "symlink")
    CONFIG_commands+=("safeSymlink $value")
    ;;
  "pkgs")
    CONFIG_pkgs+=("$value")
    ;;
  *)
    echo -e "${RED}ERROR${RESET}: No action defined for key: ${YELLOW}$key${RESET} and value: ${YELLOW}$value${RESET}"
    exit 1
    ;;
  esac
}

# Function to trim leading and trailing whitespace
trim() {
  local var="$*"
  # Remove leading whitespace characters
  var="${var#"${var%%[![:space:]]*}"}"
  # Remove trailing whitespace characters
  var="${var%"${var##*[![:space:]]}"}"
  printf "%s" "$var"
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

safeAppendToFile() {
  local string=$1
  local file=$2

  # Workaround for strings with ONE newline (only check after the newline)
  string=$(printf "%b" "$string" | tail -n 1)

  if [ -f "$file" ]; then
    if grep -q "$string" "$file"; then
      echo -e "    ${GREEN}already installed:${RESET} reference included in: ${file}"
      return
    fi
  fi
  echo "$string" >>"$file"
}

safeSymlink() {
  local source=$1
  local target=$2

  checkSymlinkTargetStatus "${target}"
  local targetStatus=$?
  case "$targetStatus" in
  0) # nothing exists at target
    ln -s "${source}" "${target}"
    echo -e "    ${GREEN}installed:${RESET} ${target}"
    ;;
  1) # symlink already exists
    existing_source=$(readlink "${target}")
    # Note: strip (optional) trailing slash from directory paths
    if [ "${existing_source%/}" == "${source%/}" ]; then
      echo -e "    ${GREEN}already installed:${RESET} ${target}"
    else
      echo "    Link exists but points to different location:"
      echo "      Existing link  -> $(readlink "${target}")"
      echo "      Installer link -> ${source}"
      overwriteWithUserPermission "${target}" "${source}"
    fi
    ;;
  2)
    echo -e "    ${RED}not installed:${RESET} broken link exists"
    echo "      Existing link  -> $(readlink "${target}")"
    echo "      Installer link -> ${source}"
    overwriteWithUserPermission "${target}" "${source}"
    ;;
  3)
    echo -e "    ${RED}not installed:${RESET} config file exists at ${target}"
    overwriteWithUserPermission "${target}" "${source}"
    ;;
  4)
    echo -e "    ${RED}not installed:${RESET} directory exists at ${target}"
    overwriteWithUserPermission "${target}" "${source}"
    ;;
  5)
    echo -e "    ${YELLOW}making directory:${RESET} $(dirname "${target}")"
    mkdir -p "$(dirname "${target}")" && ln -s "${source}" "${target}" &&
      echo -e "    ${GREEN}installed:${RESET} ${target}"
    ;;
  esac
}

overwriteWithUserPermission() {
  local target=$1
  local source=$2
  if promptToContinue "Do you want to overwrite this? (y/n) "; then
    ln -sf "${source}" "${target}"
    echo -e "    ${GREEN}installed:${RESET} ${target}"
  else
    echo -e "    ${YELLOW}skipped:${RESET} ${target}"
  fi
}

promptToContinue() {
  local question="$1"
  read -p "    $question" -n 1 -r </dev/tty
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    return 1
  fi
}

checkSymlinkTargetStatus() {
  local targetLoc=$1

  local targetDir
  targetDir=$(dirname "${targetLoc}")
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

installMissingPkgs() {
  local pkg_list="$1"

  pkg_manager=$(getFirstDetectedAsInstalled yay paru pacman apt brew choco)

  # Set package manager flags based on detected package manager
  local query_flag="list"
  local install_flag="install"
  local maybe_sudo=""

  # Package managers which use different flags/settings
  local arch_pms=("pacman" "paru" "yay")
  local linux_distro_pms=("pacman" "apt")
  if [[ " ${arch_pms[*]} " =~ ${pkg_manager} ]]; then
    query_flag="-Q"
    install_flag="-S"
  fi
  if [[ " ${linux_distro_pms[*]} " =~ ${pkg_manager} ]]; then
    maybe_sudo="sudo "
  fi

  # Find packages that are not installed
  installed_pkgs=$(eval "$pkg_manager $query_flag")
  missing_pkgs=()
  for pkg in $pkg_list; do
    if [[ " ${installed_pkgs[*]} " =~ ${pkg} ]]; then
      continue # Skip already installed packages
    else
      missing_pkgs+=("$pkg")
    fi
  done

  if [ ${#missing_pkgs[@]} -gt 0 ]; then
    echo "The following packages are not installed:"
    echo "  ${missing_pkgs[*]}"
    if promptToContinue "Do you want to install these packages with ${pkg_manager} before installing dotfiles? (y/n) "; then
      eval "${maybe_sudo}$pkg_manager ${install_flag} ${missing_pkgs[*]}"
    fi
  fi
}

getFirstDetectedAsInstalled() {
  for pm in "$@"; do
    if command -v "$pm" &>/dev/null; then
      echo "$pm"
      return
    fi
  done
  exit 1
}

run "$@"
