# Takes a list of packages and will attempt to install
# any that are not already installed.
#
# This is intended to be run in any likely environment,
# and guesses the desired package manager.
#
# Edit PRIORITIZED_LIST_OF_PMS to add more options to check.
# Also be sure to check flag settings (query_flag, install_flag, maybe_sudo)
# are handled appropriately for any new package managers
#
installMissingPkgs() {
  local pkg_list="$1"

  local PRIORITIZED_LIST_OF_PMS=(
    yay
    paru
    pacman
    apt
    brew
    choco
  )
  if ! pkg_manager=$(getFirstDetectedAsInstalled "${PRIORITIZED_LIST_OF_PMS[@]}"); then
    echo "ERROR: No package manager found"
    echo "See PRIORITIZED_LIST_OF_PMS in _installFns/installMissingPkgs.sh"
    echo "to ensure your local package manager is included"
    exit 1
  fi

  # Set package manager flags based on detected package manager
  local query_flag=" list"
  local install_flag=" install"
  local maybe_sudo=""

  # Package managers which use different flags/settings
  case "$pkg_manager" in
  "paru" | "yay")
    query_flag=" -Q"
    install_flag=" -S"
    ;;
  "pacman")
    query_flag=" -Q"
    install_flag=" -S"
    maybe_sudo="sudo "
    ;;
  "apt")
    query_flag="-mark showmanual"
    install_flag="-get install"
    maybe_sudo="sudo "
    ;;
  "brew")
    query_flag=" list -1"
    ;;
  esac

  # Find packages that are not installed
  all_installed_pkgs=$(eval "${pkg_manager}${query_flag}" | cut -d' ' -f1)
  declare -a already_installed_pkgs
  declare -a missing_pkgs
  for query_pkg in $pkg_list; do
    local found=false
    for installed_pkg in $all_installed_pkgs; do
      if [[ $installed_pkg == "$query_pkg" ]]; then
        found=true
        already_installed_pkgs+=("$query_pkg")
        break
      fi
    done
    [[ $found == false ]] && missing_pkgs+=("$query_pkg")
  done

  source _installFns/asciiColorCodes.sh # Import color constants
  echo "The following packages are already installed:"
  printf "  ${ORANGE}${already_installed_pkgs[*]}${RESET}\n"

  if [ ${#missing_pkgs[@]} -gt 0 ]; then
    echo
    echo "The following packages are not installed:"
    printf "  ${ORANGE}${missing_pkgs[*]}${RESET}\n"
    if promptToContinue "Do you want to install these packages with ${pkg_manager} before installing dotfiles? (y/n) "; then
      eval "${maybe_sudo}${pkg_manager}${install_flag} ${missing_pkgs[*]}"
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
