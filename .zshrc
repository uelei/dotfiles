# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/uelei/.oh-my-zsh"

ZSH_THEME="spaceship" 

# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# alias
alias x="exit"
alias m="make"
alias gc="git commit -S"
alias gs="git stash"
alias gsp="git stash pop"

# pyenv
export PATH="/home/uelei/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# pipx ensure path
# Created by `userpath` on 2020-05-24 12:11:57
export PATH="$PATH:/home/uelei/.local/bin"



# fix agent missing on wsl
eval $(ssh-agent -s)

# bug on wsl and spaceship
SPACESHIP_BATTERY_SHOW=false

# wsl
if (( ${+WSL_DISTRO_NAME} )); then
	export DISPLAY=192.168.1.100:0.0
	echo "exporting display for wsl"
	export GPG_TTY=$(tty)
fi

# load my personal scripts
source ~/personal_scripts/bash_sensitive.sh

function setenv(){
  if [ -z "$1" ]; then
    echo "no .env given "
  else
    export $(cat $1 | xargs)
  fi
}
