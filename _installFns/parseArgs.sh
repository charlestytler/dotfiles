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

#
# Parses arguments provided in CLI when calling install.sh
#
# @param   {sections}: Reads in an array of sections
# @param   {$@}:       Reads in all args passed in from CLI
#
# @returns {sections}: A filtered array of sections according
#                      to --include and --exclude flags
#                      specified by user in $@.
#
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
