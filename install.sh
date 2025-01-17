# #!/usr/bin/env bash

# Note: executed at end of file.
# Declare associative arrays to store sections and subsections
run() {

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

  # Check if running script from correct directory
  if [ ! -f ./install.sh ]; then
    echo "Please run this script from the dotfiles directory"
    exit 1
  fi

  DOTFILES_DIR=$(pwd)

  currentOS=$(detectOS)
  sections=$(parseConfigAndGetSections "./installConfig.cfg")

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

  echo "Installing dotfiles..."
  echo
  echo "Sections to install:"
  echo "  $sections"
  if promptToContinue "Do you want to install these sections? (y/n) "; then
    echo
    parseConfigAndHandleActions "./installConfig.cfg" "$currentOS" "$sections"
  else
    echo "Re-run script with --include/-i or --exclude/-e flags to modify sections to install"
    exit 0
  fi
}

parseConfigAndGetSections() {
  local cfg_file_path="$1"

  # Variables to track in while loop
  declare -a all_sections
  previous_section=""
  current_section=""

  while IFS= read -r line; do
    # Trim leading and trailing whitespace
    line=$(trim "$line")

    # Handle section header lines
    if [[ "$line" =~ ^\[(.*)\]$ ]]; then
      current_section="${BASH_REMATCH[1]}"
      if [[ "$current_section" =~ : ]]; then
        current_section="${current_section%%:*}"
      fi

      # Detect section change
      if [[ "$current_section" != "$previous_section" ]]; then
        all_sections+=("$current_section")
        previous_section="$current_section"
      fi
    fi

  done <"$cfg_file_path"

  # Return a list of all sections
  echo "${all_sections[*]}"
}

parseConfigAndHandleActions() {
  local cfg_file_path="$1"
  local currentOS="$2"
  local filtered_sections="$3"

  # Define color codes
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  YELLOW='\033[1;33m'
  PURPLE='\033[0;35m'
  RESET='\033[0m' # No Color

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

      # Skip sections not in the filtered list
      if [[ ! " $filtered_sections " =~ " $current_section " ]]; then
        continue
      fi

      # Detect section change
      if [[ "$current_section" != "$previous_section" ]]; then
        # Print out header for section actions once per section
        echo "${PURPLE}${current_section}${RESET}:"
        previous_section="$current_section"
      fi

      continue
    fi

    # Handle key-value pair lines
    if [[ "$line" =~ ^([^=]+)=(.*)$ ]]; then
      key=$(trim "${BASH_REMATCH[1]}")
      value=$(trim "${BASH_REMATCH[2]}")

      # Ignore if specifiedOS exists and does not equal the currentOS
      if [[ -n "$specifiedOS" && "$specifiedOS" != "$currentOS" ]]; then
        continue
      fi

      # Skip sections not in the filtered list
      if [[ ! " $filtered_sections " =~ " $current_section " ]]; then
        continue
      fi

      handleConfigActions "$key" "$value"
    fi
  done <"$cfg_file_path"
}

handleConfigActions() {
  local key="$1"
  local value="$2"

  case "$key" in
  "cmd")
    eval "$value"
    ;;
  "include")
    eval "safeAppendToFile $value"
    ;;
  "symlink")
    # set - $value
    eval "safeSymlink $value"
    ;;
  *)
    echo "${RED}ERROR${RESET}: No action defined for key: $key and value: $value"
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
      echo "    ${GREEN}already installed:${RESET} reference included in: ${file}"
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
    echo "    ${GREEN}installed:${RESET} ${target}"
    ;;
  1) # symlink already exists
    existing_source=$(readlink "${target}")
    # Note: strip (optional) trailing slash from directory paths
    if [ "${existing_source%/}" == "${source%/}" ]; then
      echo "    ${GREEN}already installed:${RESET} ${target}"
    else
      echo "    Link exists but points to different location:"
      echo "      Existing link  -> $(readlink "${target}")"
      echo "      Installer link -> ${source}"
      overwriteWithUserPermission "${target}" "${source}"
    fi
    ;;
  2)
    echo "    ${target}: not installed... broken link exists"
    echo "      Existing link  -> $(readlink "${target}")"
    echo "      Installer link -> ${source}"
    overwriteWithUserPermission "${target}" "${source}"
    ;;
  3)
    echo "    ${RED}not installed:${RESET} ${target}: config file exists at location"
    overwriteWithUserPermission "${target}" "${source}"
    ;;
  4)
    echo "    ${RED}not installed:${RESET} ${target}: directory exists at location"
    overwriteWithUserPermission "${target}" "${source}"
    ;;
  5)
    echo "    ${YELLOW}making directory at:${RESET} $(dirname "${target}")"
    mkdir -p "$(dirname "${target}")" && ln -s "${source}" "${target}" &&
      echo "    ${GREEN}installed:${RESET} ${target}"
    ;;
  esac
}

overwriteWithUserPermission() {
  local target=$1
  local source=$2
  if promptToContinue "Do you want to overwrite this? (y/n) "; then
    ln -sf "${source}" "${target}"
    echo "    ${GREEN}installed:${RESET} ${target}"
  else
    echo "    ${YELLOW}skipped:${RESET} ${target}"
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

run "$@"
