# Example use:
#
# promptToContinue "Do you want to proceed? (y/n) " && <command>
#
promptToContinue() {
  local question="$1"
  read -p "    $question" -n 1 -r </dev/tty
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    return 1
  fi
}
