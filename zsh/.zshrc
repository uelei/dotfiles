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

export NVM_COMPLETION=true
export NVM_SYMLINK_CURRENT="true"

# wsl
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
### Added by Zinit's installer
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
### End of Zinit's installer chunk
echo "load zinit plugins"

zinit wait lucid light-mode for lukechilds/zsh-nvm

zinit wait lucid for \
    light-mode atinit"ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50" atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    light-mode atinit"typeset -gA FAST_HIGHLIGHT; FAST_HIGHLIGHT[git-cmsg-len]=100; zpcompinit; zpcdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
                        OMZ::lib/git.zsh \
                        OMZ::lib/completion.zsh \
                        OMZ::lib/theme-and-appearance.zsh \
                        OMZ::lib/history.zsh \
                        OMZ::lib/clipboard.zsh \
                        OMZ::lib/directories.zsh \
                        OMZ::lib/key-bindings.zsh \
    atload"unalias grv" OMZ::plugins/git/git.plugin.zsh \
                        OMZ::plugins/docker-compose \
                        OMZ::plugins/kubectl \
  as"completion" \
        OMZP::docker/_docker

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

echo "loading starship"
# Theme starship > spaceship
eval "$(starship init zsh)"

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

echo "loading compinit lazy turbo"
zi for \
    atload"zicompinit; zicdreplay" \
    blockf \
    lucid \
    wait \
  zsh-users/zsh-completions
echo "done"

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# load plugins after 5 seconds verbose 
zinit wait"5" for \
    djui/alias-tips
