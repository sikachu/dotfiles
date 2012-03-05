# ADD LOCAL CONFIGURATION HERE


# DO NOT EDIT BELOW THIS LINE

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
autoload -U compinit
compinit

# automatically enter directories without cd
setopt auto_cd

# use MacVim as an editor
export EDITOR="mvim -f"
export PSQL_EDITOR='mvim -f +"set syntax=sql" '

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# vi mode
bindkey -v

# use incremental search
bindkey ^R history-incremental-search-backward

# expand functions in the prompt
setopt prompt_subst

# prompt
export PS1='[${SSH_CONNECTION+"%n@%m:"}%~] '

# ignore duplicate history entries
#setopt histignoredups

# keep more history
export HISTSIZE=5000
export SAVEHIST=5000
export HISTFILE=~/.zsh_history

# Set MySQL Paths
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"

# Set architecture to x86_64
export ARCHFLAGS="-arch x86_64"

# Set Node Paths
export NODE_PATH="/usr/local/lib/node"

export RB_FSEVENT=1

# rvm-install added line:
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

# Set python paths
export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH
export PATH="/usr/local/share/python:$PATH"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
