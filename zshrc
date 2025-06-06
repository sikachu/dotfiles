# Tell the terminal about the working directory whenever it changes.
if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]] && [[ -z "$INSIDE_EMACS" ]]; then
  update_terminal_cwd() {
    # Identify the directory using a "file:" scheme URL, including
    # the host name to disambiguate local vs. remote paths.

    # Percent-encode the pathname.
    local URL_PATH=''
    {
      # Use LANG=C to process text byte-by-byte.
      local i ch hexch LANG=C
      for ((i = 1; i <= ${#PWD}; ++i)); do
        ch="$PWD[i]"
        if [[ "$ch" =~ [/._~A-Za-z0-9-] ]]; then
          URL_PATH+="$ch"
        else
          hexch=$(printf "%02X" "'$ch")
          URL_PATH+="%$hexch"
        fi
      done
    }

    local PWD_URL="file://$HOST$URL_PATH"
    #echo "$PWD_URL"        # testing
    printf '\e]7;%s\a' "$PWD_URL"
  }

  # Register the function so it is called whenever the working
  # directory changes.
  autoload add-zsh-hook
  add-zsh-hook chpwd update_terminal_cwd

  # Tell the terminal about the initial directory.
  update_terminal_cwd
fi

# completion
autoload -Uz compinit
compinit

# automatically enter directories without cd
setopt auto_cd

# set appropriate editor
if [[ -x "$(command -v mvim)" ]]; then
  export EDITOR="mvim -f"
  export PSQL_EDITOR='mvim -f +"set syntax=sql" '
else
  export EDITOR="vim -f"
  export PSQL_EDITOR='vim -f +"set syntax=sql" '
fi

# set UTF8 encoding
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# aliases
if [ -e "$HOME/.aliases" ]; then; source "$HOME/.aliases"; fi
if [ -d "$HOME/.aliases.d" ]; then
  for file in ~/.aliases.d/*; do
    source "$file"
  done
fi

# vi mode
bindkey -v

# use incremental search
bindkey ^R history-incremental-search-backward

# accept ^[[H and ^[[F as home/end
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# accept ^[[3~ as delete
bindkey "^[[3~" delete-char

# expand functions in the prompt
setopt prompt_subst

# prompt
export PS1='[${SSH_CONNECTION+"%n@%m:"}%~] '

# ignore duplicate history entries
setopt histignoredups

# do not save command starting with space
setopt hist_ignore_space

# share history betweens sessions
setopt share_history

# keep more history
export HISTSIZE=5000
export SAVEHIST=5000
export HISTFILE=~/.zsh_history

# Setup RVM
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

# Setup rbenv
if [[ -d ~/.rbenv ]]; then
  if [[ -s /opt/homebrew/bin/rbenv ]]; then
    eval "$(/opt/homebrew/bin/rbenv init - zsh)"
  else
    eval "$(~/.rbenv/bin/rbenv init - zsh)"
  fi
fi

# Setup paths
export PATH="$HOME/.rd/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# Setup direnv hook
eval "$(direnv hook zsh)"

# Setup global plugin cache for terraform
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"

# Setup fzf
export FZF_DEFAULT_COMMAND='ag -g ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add kubetl autocompletion
[ -s /usr/local/bin/kubectl ] && source <(kubectl completion zsh)

# Always run grep with color
export GREP_OPTIONS="--color=auto"

# No more hints, please
export HOMEBREW_NO_ENV_HINTS=1

# Add color to less
export LESS_TERMCAP_mb=$(printf '\e[01;31m') # enter blinking mode – red
export LESS_TERMCAP_md=$(printf '\e[01;35m') # enter double-bright mode – bold, magenta
export LESS_TERMCAP_me=$(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m') # leave standout mode
export LESS_TERMCAP_so=$(printf '\e[01;33m') # enter standout mode – yellow
export LESS_TERMCAP_ue=$(printf '\e[0m') # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;36m') # enter underline mode – cyan

# Rust
if [ -d "$HOME/.cargo" ]; then
  source "$HOME/.cargo/env"
fi

# Load additional zshrc configs from ~/.zshrc.d/*
if [ -d "$HOME/.zshrc.d" ]; then
  for file in ~/.zshrc.d/*; do
    source "$file"
  done
fi
