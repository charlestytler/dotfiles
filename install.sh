# #!/usr/bin/env bash

# Note: executed at end of file.
# Declare associative arrays to store sections and subsections
run() {
  # Check if running script from correct directory
  if [ ! -f ./install.sh ]; then
    echo "Please run this script from the dotfiles directory"
    exit 1
  fi

  DOTFILES_DIR=$(pwd)

  echo "Installing dotfiles..."
  currentOS=$(detectOS)
  sections=$(parseConfigAndGetSections "./installConfig.cfg")
  echo
  echo "Sections to install:"
  echo "$sections"
  promptToContinue "Do you want to install all sections? (y/n) " || exit 0
  parseConfigAndHandleActions "./installConfig.cfg" "$currentOS"
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
        # Print out header for section actions once per section
        echo "${current_section}:"
        previous_section="$current_section"
      fi

      continue
    fi

    # Handle key-value pair lines
    if [[ "$line" =~ ^([^=]+)=(.*)$ ]]; then

      # Ignore if specifiedOS exists and does not equal the currentOS
      if [[ -n "$specifiedOS" && "$specifiedOS" != "$currentOS" ]]; then
        continue
      fi

      key=$(trim "${BASH_REMATCH[1]}")
      value=$(trim "${BASH_REMATCH[2]}")
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
    echo "ERROR: No action defined for key: $key and value: $value"
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
      echo "    skipping... reference already included in config file"
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
    echo "    ${target}: installed"
    ;;
  1) # symlink already exists
    existing_source=$(readlink "${target}")
    # Note: strip (optional) trailing slash from directory paths
    if [ "${existing_source%/}" == "${source%/}" ]; then
      echo "    ${target}: not installed... link already exists"
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
    echo "    ${target}: not installed... config file exists"
    overwriteWithUserPermission "${target}" "${source}"
    ;;
  4)
    echo "    ${target}: not installed... directory exists"
    overwriteWithUserPermission "${target}" "${source}"
    ;;
  5)
    echo "    ${target}: not installed... parent directory does not exist"
    echo "    Make sure ${target} is properly installed first"
    ;;
  esac
}

overwriteWithUserPermission() {
  local target=$1
  local source=$2
  promptToContinue "Do you want to overwrite this? (y/n) " && ln -sf "${source}" "${target}" || echo "    ${target}: skipped"
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
