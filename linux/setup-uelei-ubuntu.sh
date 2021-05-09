#!/usr/bin/env bash

echo "setup uelei ubuntu/debian version"


echo -n "Install apt-get stuffs (y/n)? "
read answer
if [ "$answer" = "y" -o "$answer" = "Y" ] ;then
    echo "intalling basics apt-get stuffs"

    sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
        libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
        xz-utils tk-dev libffi-dev liblzma-dev python-openssl libtool cmake
fi

echo -n "Install ho my zsh (y/n)? "
read answer
if [ "$answer" = "y" -o "$answer" = "Y" ] ;then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi


echo -n "Install pyenv (y/n)? "
read answer
if [ "$answer" = "y" -o "$answer" = "Y" ] ;then
    # pyenv
    curl https://pyenv.run | bash

    # add to bashrc
    # export PATH="/home/uelei/.pyenv/bin:$PATH"
    # eval "$(pyenv init -)"
    # eval "$(pyenv virtualenv-init -)"
    pyenv install 3.8.8
    pyenv global 3.8.8

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
