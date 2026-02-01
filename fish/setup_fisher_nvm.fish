#!/usr/bin/env fish

if not functions -q fisher
    echo "><> Installing Fisher..."
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
else
    echo "><> Fisher is already installed. Skipping..."
end

if functions -q fisher
    echo "><> Installing nvim.fish..."
    fisher install jorgebucaran/nvm.fish

    # 3. Install Node.js LTS and set as default
    if functions -q nvm
      echo "><> Installing Node.js LTS..."
      nvm install lts > /dev/null
      set -U nvm_default_version lts
      echo "><> Node.js LTS installed and set as default."
else
    echo "!! Error: nvm function not found. Installation might have failed."
end
    
else
    echo "!! Error: Fisher installation failed."
    exit 1
end

