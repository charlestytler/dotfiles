# User configuration with version control is all maintained in `conf.d/`
# where each file is loaded in alphabetical order (00-*, 10-*, etc.)

# This file is gitignored, so settings that are machine-specific can be added here.

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting


# NPM 
# requires "fisher install jorgebucaran/nvm.fish"
#     https://github.com/jorgebucaran/fisher
set -xU nvm_default_version 22

