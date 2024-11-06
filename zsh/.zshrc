
# # tmux autoinit
# if [ -z $TMUX ]; then; tmux; fi

# set Zinit home
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there
if [ ! -d $ZINIT_HOME ]; && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# source Zinit
source "${ZINIT_HOME}/zinit.zsh"

# start starship Terminal
eval "$(starship init zsh)"

# Add in zsh plugins
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::kubectl
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# History
#
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=29000
SAVEHIST=$HISTSIZE
HISTDUP=erase
HIST_STAMPS=yyyy.mm.dd
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'
alias :q='exit'
alias x="exit"
alias m="make"
alias n="nvim"
alias lgit="lazygit"
alias tf='terraform'
alias gs="git stash"
alias gsp="git stash pop"

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

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

echo "load personal configs"
# load my personal scripts
if [[ -f $HOME/uelei_files/bash_sensitive.sh ]]; then
    source $HOME/uelei_files/bash_sensitive.sh
fi

# rust cargo
export PATH=$PATH:$HOME/.cargo/bin

# pipx ensure path
export PATH="$PATH:$HOME/.local/bin"

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# gvm
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# tfenv terraform
export PATH="$HOME/.tfenv/bin:$PATH"

# Functions 
myip() echo "External :: IP => $( curl --silent https://ifconfig.me )"

function setenv(){
  if [ -z "$1" ]; then
    echo "no .env given "
  else
    export $(cat $1 | xargs)
  fi
}

# load fzf 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

