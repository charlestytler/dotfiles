# Define color codes
#
# Wrap text with a <Color> then ${RESET} to contain formatting properly
#
# Example:
# echo "${RED}My red ${RESET} then plain and ${GREEN}green text${RESET}"
#
local RED='\033[0;31m'
local GREEN='\033[0;32m'
local YELLOW='\033[1;33m'
local ORANGE='\033[0;33m'
local RESET='\033[0m' # No Color
