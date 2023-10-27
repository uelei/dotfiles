# User configuration
# alias
alias :q="exit"
alias x="exit"
alias m="make"
alias n="nvim"
alias lgit="lazygit"
alias lv="lvim"

alias e="exa --icons "
alias b="bat --style=auto "

alias g="git"
alias gc="git commit -S"
alias gs="git stash"
alias gsp="git stash pop"

alias dc="docker-compose"
alias dcs="docker-compose stop"
alias dcc="docker compose kill ; docker compose down; docker compose rm -f ; docker system prune -f ; docker volume prune -f"

# https://github.com/chubin/wttr.in
alias weather='curl http://wttr.in'

# crypto coin tracker
alias ratesx='curl rate.sx'

# changes for os type
case "$OSTYPE" in
    darwin*)
        # macos
        echo "macos settings"
        # mac postgres client
        export PATH="/usr/local/opt/libpq/bin:$PATH"
        ;;
    linux*)
        # linux settings
        # load brew on linux
        # echo "linux settings"
        # if [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
        #     echo "loading linuxbrew"
        #     eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        # fi
        ;;
esac

echo "load pipx path"
# pipx ensure path
export PATH="$PATH:$HOME/.local/bin"

# NVM
echo "load nvm"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# export NVM_COMPLETION=true
# export NVM_SYMLINK_CURRENT="true"

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
    # dont need in new wslg
    # https://devblogs.microsoft.com/commandline/wslg-architecture/
    # echo "exporting display for wsl"
    # export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
    # export GPG_TTY=$(tty)
fi

echo "load personal configs"
# load my personal scripts
if [[ -f $HOME/uelei_files/bash_sensitive.sh ]]; then
    source $HOME/uelei_files/bash_sensitive.sh
fi

# Functions 
ip-external() echo "External :: IP => $( curl --silent https://ifconfig.me )"
function setenv(){
  if [ -z "$1" ]; then
    echo "no .env given "
  else
    export $(cat $1 | xargs)
  fi
}

# go 
export GOPATH=/usr/local/go
export PATH=$PATH:$GOPATH/bin

echo "load zinit"
# Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# ### End of Zinit's installer chunk
echo "load zinit plugins"

# #####################
# # PROMPT            #
# #####################
zinit lucid for \
    as"command" \
    from"gh-r" \
    atinit'export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"' atload'eval "$(starship init zsh)"' \
    starship/starship
##########################
# OMZ Libs and Plugins   #
##########################
# IMPORTANT:
# Ohmyzsh plugins and libs are loaded first as some these sets some defaults which are required later on.
# Otherwise something will look messed up
# ie. some settings help zsh-autosuggestions to clear after tab completion
setopt promptsubst
# Explanation:
# 1. Loading tmux first, to prevent jumps when tmux is loaded after .zshrc
# 2. History plugin is loaded early (as it has some defaults) to prevent empty history stack for other plugins
zinit lucid for \
    atinit"
      ZSH_TMUX_FIXTERM=false
      ZSH_TMUX_AUTOSTART=false
      ZSH_TMUX_AUTOCONNECT=false" \
  OMZP::tmux \
  atinit"HIST_STAMPS=yyyy.mm.dd" \
  OMZL::history.zsh \

zinit wait lucid for \
	OMZL::clipboard.zsh \
	OMZL::compfix.zsh \
	OMZL::completion.zsh \
	OMZL::correction.zsh \
    atload"
      alias ..='cd ..'
      alias ...='cd ../..'
      alias ....='cd ../../..'
      alias .....='cd ../../../..'" \
	OMZL::directories.zsh \
	OMZL::git.zsh \
	OMZL::grep.zsh \
	OMZL::key-bindings.zsh \
	OMZL::spectrum.zsh \
      OMZ::lib/theme-and-appearance.zsh \
    atload"alias gcd='gco dev'" \
	OMZP::git \
	OMZP::fzf \
    atload"
      alias dcupb='docker-compose up --build' \
      alias dc='docker-compose'" \
	OMZP::docker-compose \
    as"completion" \
  OMZP::docker/completions/_docker \
  djui/alias-tips \
  hlissner/zsh-autopair \
  chriskempson/base16-shell\
  zsh-users/zsh-autosuggestions\
  zdharma-continuum/fast-syntax-highlighting \
  zsh-users/zsh-completions\
  zdharma-continuum/history-search-multi-word\
  trapd00r/LS_COLORS

if [ -f pyproject.toml ] || [[ "$OSTYPE" != "darwin"* ]]; then
    echo "loading pyenv"
    export PYENV_ROOT="$HOME/.pyenv" 
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
else
    # Load pyenv lazy
    echo "lazy loading pyenv"
    zinit wait"1" for davidparsson/zsh-pyenv-lazy
fi

# rust cargo
export PATH=$PATH:$HOME/.cargo/bin

# gvm
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# tfenv terraform
export PATH="$HOME/.tfenv/bin:$PATH"

# fix first install can be removed later
if [[ ! -e $HOME/.cache/zinit/completions ]]; then
  echo "creating a inital folder for zinit completions"
  mkdir -p $HOME/.cache/zinit/completions
fi

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# tmux autoinit
if [ -z $TMUX ]; then; tmux; fi
