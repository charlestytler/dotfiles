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
