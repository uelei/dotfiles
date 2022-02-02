# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# User configuration

# alias
alias x="exit"
alias m="make"
alias gc="git commit -S"
alias gs="git stash"
alias gsp="git stash pop"
alias pya="pyenv activate"
alias pyd="pyenv deactivate"
alias dc="docker-compose"
alias dcps="docker-compose ps"
alias dcs="docker-compose stop"
alias dcc="docker compose kill ; docker compose rm -f ; docker system prune -f ; docker volume prune -f"

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
        echo "linux settings"
        if [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
            echo "loading linuxbrew"
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi
        ;;
esac

# pyenv
# nedd to add the following lines to ~/.zprofile
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

echo "load pyenv"
eval "$(pyenv init --path --no-rehash)"
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

echo "load pipx path"
# pipx ensure path
export PATH="$PATH:$HOME/.local/bin"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

echo "load dropbox configs"
# load my personal scripts
if [[ -f $HOME/Dropbox/uelei_files/personal_scripts/bash_sensitive.sh ]]; then
    source $HOME/Dropbox/uelei_files/personal_scripts/bash_sensitive.sh
fi

function setenv(){
  if [ -z "$1" ]; then
    echo "no .env given "
  else
    export $(cat $1 | xargs)
  fi
}

# go 
export PATH=$PATH:/usr/local/go/bin

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
zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions \
      OMZP::git

zinit snippet OMZL::theme-and-appearance.zsh

# Theme starship > spaceship
if [[ "$OSTYPE" != "darwin"* ]]; then
    # Mac OSX
    echo "instaling starship using zinit"
    zinit light starship/starship
fi
echo "loading starship"
eval "$(starship init zsh)"

# rust cargo
export PATH=$PATH:$HOME/.cargo/bin
