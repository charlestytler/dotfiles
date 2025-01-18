# Function checks if desired link already exists and matches desired target.
# If it does not exist it creates the symlink (will also make parent directory if needed)
# If there is already a symlink, file or directory at desired location, then
# it will prompt user if they would like to overwrite it.
#
# Essentially wraps around `ln -s <target> <link>``
#
safeSymlink() {
  local target=$1
  local link=$2
  source _installFns/asciiColorCodes.sh # Import color constants

  checkSymlinkStatus "${link}"
  local linkStatus=$?
  case "$linkStatus" in
  0) # nothing exists at link
    ln -s "${target}" "${link}"
    echo -e "    ${GREEN}installed:${RESET} ${link}"
    ;;
  1) # symlink already exists
    existing_target=$(readlink "${link}")
    # Note: strip (optional) trailing slash from directory paths
    if [ "${existing_target%/}" == "${target%/}" ]; then
      echo -e "    ${GREEN}already installed:${RESET} ${link}"
    else
      echo "    Link exists but points to different location:"
      echo "      Existing link  -> $(readlink "${link}")"
      echo "      Installer link -> ${target}"
      overwriteSymlinkWithUserPermission "${target}" "${link}"
    fi
    ;;
  2)
    echo -e "    ${RED}not installed:${RESET} broken link exists"
    echo "      Existing link  -> $(readlink "${link}")"
    echo "      Installer link -> ${target}"
    overwriteSymlinkWithUserPermission "${target}" "${link}"
    ;;
  3)
    echo -e "    ${RED}not installed:${RESET} config file exists at ${link}"
    overwriteSymlinkWithUserPermission "${target}" "${link}"
    ;;
  4)
    echo -e "    ${RED}not installed:${RESET} directory exists at ${link}"
    overwriteSymlinkWithUserPermission "${target}" "${link}"
    ;;
  5)
    echo -e "    ${YELLOW}making directory:${RESET} $(dirname "${link}")"
    mkdir -p "$(dirname "${link}")" && ln -s "${target}" "${link}" &&
      echo -e "    ${GREEN}installed:${RESET} ${link}"
    ;;
  esac
}

overwriteSymlinkWithUserPermission() {
  local target=$1
  local link=$2
  target ./promptToContinue.sh # Import promptToContinue function

  if promptToContinue "Do you want to overwrite this? (y/n) "; then
    ln -sf "${target}" "${link}"
    echo -e "    ${GREEN}installed:${RESET} ${link}"
  else
    echo -e "    ${YELLOW}skipped:${RESET} ${link}"
  fi
}

# Checks status of symlink at a provided location
#
# @param {linkLoc}: Location of symlink
# @returns {exit code}:
#   0 - No symlink at location
#   1 - Existing symlink with good link at location
#   2 - Existing symlink with broken link at location
#   3 - Existing file at location
#   4 - Existing directory at location
#   5 - Parent directory does not exist
#
checkSymlinkStatus() {
  local linkLoc=$1

  local linkDir
  linkDir=$(dirname "${linkLoc}")
  if [ ! -d "${linkDir}" ]; then
    # "Parent directory does not exist"
    return 5 # false
  fi

  if [ -L "${linkLoc}" ]; then
    if [ -e "${linkLoc}" ]; then
      # "Good link already exists"
      return 1 # false
    else
      # "Link exists, but is broken"
      return 2 # false
    fi
  elif [ -f "${linkLoc}" ]; then
    # "File exists and is not a link"
    return 3 # false
  elif [ -d "${linkLoc}" ]; then
    # "Directory exists and is not a link"
    return 4 # false
  else
    # "No file or link exists"
    return 0 # true
  fi
}
