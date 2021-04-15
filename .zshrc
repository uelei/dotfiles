# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/uelei/.oh-my-zsh"

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


# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# bug on wsl and spaceship
# SPACESHIP_BATTERY_SHOW=false

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
    # trap 'ssh-agent -k; exit' 0


    echo "exporting display for wsl"
    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
    export GPG_TTY=$(tty)


	# if grep -qs '/mnt/g ' /proc/mounts; then
	# 	echo "its mounted"
    #     else
	# 	echo "not mounted"

	# 	sudo mount -t drvfs d: /mnt/g
	# fi

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

# go 
export PATH=$PATH:/usr/local/go/bin


### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

# install theme
zinit light denysdovhan/spaceship-prompt

ZSH_THEME="spaceship" 

# rust cargo
# export PATH=$PATH:$HOME/.cargo/bin
