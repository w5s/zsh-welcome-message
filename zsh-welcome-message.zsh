typeset -g ZSH_WELCOME_MESSAGE_SHOWN=false
ZSH_WELCOME_MESSAGE_ENABLED=${ZSH_WELCOME_MESSAGE_ENABLED:-true}
ZSH_WELCOME_MESSAGE_COMMAND="${ZSH_WELCOME_MESSAGE_COMMAND:-}"

_zsh_welcome_banner_disabled() {
  [ -e "$HOME/.hushlogin" ]
}

_zsh_welcome_banner_shown() {
  [[ "$ZSH_WELCOME_MESSAGE_SHOWN" == true ]]
}

_zsh_welcome_banner_should_display() {
  if _zsh_welcome_banner_disabled || _zsh_welcome_banner_shown; then
    return 1
  else
    return 0
  fi
}

# Function to show the welcome banner and a random quote once per session.
zsh_welcome_banner_message() {
  if _zsh_welcome_banner_should_display; then
    # Execute the welcome message command if it is set.
    if [[ -n "$ZSH_WELCOME_MESSAGE_COMMAND" ]]; then
      zsh -c "$ZSH_WELCOME_MESSAGE_COMMAND" || true
    fi
    ZSH_WELCOME_MESSAGE_SHOWN=true  # Set the flag to true to avoid repeated displays.
  fi
}

# Automatically show the welcome message if it is enabled.
if [[ "$ZSH_WELCOME_MESSAGE_ENABLED" == true ]]; then
  zsh_welcome_banner_message
fi