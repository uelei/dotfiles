# # tmux autoinit
# if [ -z $TMUX ]; then; tmux; fi
export XDG_CONFIG_HOME="${HOME}/.config"

# set Zinit home
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there
[[ ! -d $ZINIT_HOME ]] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# source Zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Oh My Zsh snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::docker
zinit snippet OMZP::kubectl
zinit snippet OMZL::history.zsh

# Add in zsh plugins
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma-continuum/history-search-multi-word

zinit load 'zsh-users/zsh-history-substring-search'
zinit ice wait atload'_history_substring_search_config'
# Load completions
autoload -Uz compinit && compinit

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

zinit cdreplay -q

# Prompt (after plugins so they don't override it)
eval "$(starship init zsh)"

# load Mise (before aliases so mise-installed tools are available)
if [[ -f $HOME/.local/bin/mise ]]; then
    eval "$(~/.local/bin/mise activate zsh)"
fi

# Aliases
# Use eza if available, otherwise fallback to ls
if command -v eza &> /dev/null; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -lh --icons --group-directories-first'
    alias la='eza -lah --icons --group-directories-first'
    alias lt='eza -T --icons --level=2'
else
    # Fallback to standard ls with platform-appropriate flags
    if [[ "$OSTYPE" == "darwin"* ]]; then
        alias ls='ls -G'
    else
        alias ls='ls --color=auto'
    fi
fi

# Use bat if available, otherwise fallback to cat
if command -v bat &> /dev/null; then
    alias cat='bat --style=auto'
    alias catp='bat --plain'  # Plain output without decorations
    alias batl='bat --paging=always'  # Force pager for long files
fi

alias c='clear'
alias :q='exit'
alias x="exit"
alias m="make"
alias n="nvim"
alias lgit="lazygit"
alias tf='terraform'
alias gs="git stash"
alias gsp="git stash pop"
alias ..='cd ..'
alias grep='grep --color=auto'

# WSL
if (( ${+WSL_DISTRO_NAME} )); then
    # fix agent missing on wsl
    ps -u $(whoami) | grep ssh-agent &> /dev/null
    if [ $? -ne 0 ];then
        echo "exporting new ssh agent"
        eval $(ssh-agent)
        ssh-add
        echo "export SSH_AGENT_PID=$SSH_AGENT_PID" > ~/.agent-profile
        echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" >> ~/.agent-profile
    else
        echo "using ssh agent"
        source ~/.agent-profile
    fi
fi

echo "load personal configs"
# load my personal scripts
if [[ -f $HOME/uelei_files/bash_sensitive.sh ]]; then
    source $HOME/uelei_files/bash_sensitive.sh
fi

# Functions 
myip() echo "External :: IP => $( curl --silent https://ifconfig.me )"

function setenv(){
  if [ -z "$1" ]; then
    echo "no .env given "
  else
    export $(cat $1 | xargs)
  fi
}

# zoxide
eval "$(zoxide init zsh)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"
