# Set current prompt based on git branch, also makes it RED if we are on main/master
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    if [[ "${ref#refs/heads/}" == "master" ]] || [[ "${ref#refs/heads/}" == "main" ]]; then
      echo "[%{$fg_bold[red]%}${ref#refs/heads/}%{$reset_color%}]"
    else
      echo "[%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}]"
    fi
  fi
}

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# expand functions in the prompt
setopt prompt_subst

# prompt
short_prompt() {
  echo '[${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%~%{$reset_color%}] '
}
long_prompt() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "┣ [${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%~%{$reset_color%}] "
    echo "┗ $(git_prompt_info) "
  else
    echo "┗ [${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%~%{$reset_color%}] "
  fi
}

# Only display k8s prompt if kube-ps1 is installed
if [[ -f "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh" ]]; then
  # Show green/yellow/red color based on k8s cluster name
  function kb_cluster_color() {
    if [[ $1 == *"development"* ]]; then
      echo "$fg[green]$1"
    elif [[ $1 == *"staging"* ]]; then
      echo "$fg[yellow]$1"
    else
      echo $1
    fi
  }
  export KUBE_PS1_CLUSTER_FUNCTION=kb_cluster_color
  source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
  kubeoff
else
  # Define an empty kube_ps1 function
  kube_ps1() {}
fi

# Display warning if there's an uncommit changes in Dotfiles
dotfiles_warnings() {
  if [[ -d "$HOME/.dotfiles" ]]; then
    (cd "$HOME/.dotfiles" && git diff --exit-code --quiet)
    if [[ $? != 0 ]]; then; echo " ⚠️"; fi
  fi
}

# Set fancy prompt
export PS1='┏ (— ＿＿＿—  X)$(dotfiles_warnings)$(kube_ps1)
$(long_prompt)'

# This function will be called by zsh before it runs a command.
# We need to define it so it will retain the prompt.
precmd() {
  precmd() {
      echo
  }
}

# This causes zsh to delete the line and replace with short prompt after
# pressing a return key.
del-prompt-accept-line() {
  OLD_PROMPT="$PROMPT"
  PROMPT="─ $(short_prompt)"
  zle reset-prompt
  PROMPT="$OLD_PROMPT"
  zle accept-line
}
zle -N del-prompt-accept-line
bindkey "^M" del-prompt-accept-line

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Source private zlogin file if exist
if [[ -f "$HOME/.zlogin-private" ]]; then; source "$HOME/.zlogin-private"; fi
