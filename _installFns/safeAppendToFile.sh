# Function checks if a string is already in a file before appending it.
#
# Essentially wraps around `echo "$string" >>"$file"`
#
safeAppendToFile() {
  local string=$1
  local file=$2
  source _installFns/asciiColorCodes.sh # Import color constants

  # Workaround for strings with ONE newline (only check after the newline)
  string=$(printf "%b" "$string" | tail -n 1)

  if [ -f "$file" ]; then
    if grep -q "$string" "$file"; then
      printf "    ${GREEN}already installed:${RESET} reference included in: ${file}\n"
      return
    fi
  fi
  echo "$string" >>"$file"
}
