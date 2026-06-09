# vim: set filetype=zsh:

# Setup Homebrew
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Setup mise
if [[ -d "$HOME/.local/share/mise" ]]; then
  eval "$(mise activate zsh --shims)"
fi
