#!/usr/bin/env bash

echo " setup uelei ubuntu version"


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

    #pipsi

    curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python

    # pipenv
    pipsi install pipenv
    # upgrade
    # pipsi upgrade Pygments
fi

echo -n "Install mongo 4.0 (y/n)? "
read answer
if [ "$answer" = "y" -o "$answer" = "Y" ] ;then
    # mongo
    wget -qO - https://www.mongodb.org/static/pgp/server-4.0.asc | sudo apt-key add -
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
    sudo apt install mongodb-org
fi

echo -n "Install emacs (y/n)? "
read answer
if [ "$answer" = "y" -o "$answer" = "Y" ] ;then
	echo "Intalling Emacs26 ppa"
    sudo add-apt-repository ppa:kelleyk/emacs
	sudo apt-get update 
	sudo apt-get install emacs26

fi


echo -n "Install postgresql (y/n)? "
read answer
if [ "$answer" = "y" -o "$answer" = "Y" ] ;then
    sudo apt-get install -y postgresql postgresql-contrib

fi

echo "Done"
