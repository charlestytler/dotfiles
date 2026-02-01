# This function expects to modify the following externally defined variables:
#
# extern CONFIG_sections
# extern CONFIG_commands
# extern INSTALL_commands
#
parseConfigForSectionsAndCommands() {
  local cfg_file_path="$1"
  local currentOS="$2"
  local filtered_sections="$3"
  source _installFns/asciiColorCodes.sh # Import color constants

  # Variables to track in while loop
  previous_section=""
  current_section=""
  specifiedOS=""

  while IFS= read -r line; do
    # Trim leading and trailing whitespace
    line=$(trimWhiteSpace "$line")

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
          CONFIG_commands+=("printf \"${ORANGE}${current_section}${RESET}:\\n\"")
      fi

      continue
    fi

    # Handle key-value pair lines
    if [[ "$line" =~ ^([^=]+)=(.*)$ ]]; then
      key=$(trimWhiteSpace "${BASH_REMATCH[1]}")
      value=$(trimWhiteSpace "${BASH_REMATCH[2]}")
      # Ignore if specifiedOS exists and does not equal the currentOS
      [[ -n "$specifiedOS" && "$specifiedOS" != *"$currentOS"* ]] && continue
      # Skip sections not in the filtered list
      [[ ! " $filtered_sections " =~ " $current_section " ]] && continue

      handleConfigActions "$key" "$value"
    fi
  done <"$cfg_file_path"
}

# Function to handle all key:value actions defined in config file sections
handleConfigActions() {
  local key="$1"
  local value="$2"
  source _installFns/asciiColorCodes.sh  # Import color constants
  source _installFns/safeAppendToFile.sh # Import safeAppendToFile
  source _installFns/safeSymlink.sh      # Import safeSymlink

  case "$key" in
  "cmd")
    local success_msg="    ${GREEN}installed:${RESET} cmd successful"
    local failed_msg="    ${RED}failed:${RESET} cmd failed"
    CONFIG_commands+=("$value")
    CONFIG_commands+=("[ $? -eq 0 ] && printf \"$success_msg\\n\" || echo -e \"$failed_msg\\n\"")
    ;;
  "include")
    CONFIG_commands+=("safeAppendToFile $value")
    ;;
  "symlink")
    CONFIG_commands+=("safeSymlink $value")
    ;;
  "install")
    INSTALL_commands+=("$value")
    ;;
  *)
    printf "${RED}ERROR${RESET}: No action defined for key: ${YELLOW}$key${RESET} and value: ${YELLOW}$value${RESET}\n"
    exit 1
    ;;
  esac
}

# Function to trim leading and trailing whitespace
trimWhiteSpace() {
  local var="$*"
  # Remove leading whitespace characters
  var="${var#"${var%%[![:space:]]*}"}"
  # Remove trailing whitespace characters
  var="${var%"${var##*[![:space:]]}"}"
  printf "%s" "$var"
}
