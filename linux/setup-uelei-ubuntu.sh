#!/usr/bin/env bash

echo "setup uelei ubuntu/debian version"


echo -n "Install apt-get stuffs (y/n)? "
read answer
if [ "$answer" = "y" -o "$answer" = "Y" ] ;then
    echo "intalling basics apt-get stuffs"
    sudo apt-get install --no-install-recommends git htop make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev openssh-server zsh vim python3.6-dev
fi

echo -n "Install ho my zsh (y/n)? "
read answer
if [ "$answer" = "y" -o "$answer" = "Y" ] ;then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

echo -n "Install pyenv + pipsi + pipenv (y/n)? "
read answer
if [ "$answer" = "y" -o "$answer" = "Y" ] ;then
    # pyenv
    curl https://pyenv.run | bash

    # add to bashrc
    # export PATH="/home/uelei/.pyenv/bin:$PATH"
    # eval "$(pyenv init -)"
    # eval "$(pyenv virtualenv-init -)"

    # pipsi
    curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python

    # pipenv
    pipsi install pipenv
    # upgrade
    # pipsi upgrade Pygments
fi


echo -n "Install emacs (y/n)? "
read answer
if [ "$answer" = "y" -o "$answer" = "Y" ] ;then
	echo "Intalling Emacs27 ppa"
    sudo add-apt-repository ppa:kelleyk/emacs
	sudo apt-get update 
	sudo apt-get install emacs27

fi

echo "Done"
