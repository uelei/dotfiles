# Dotfiles

My dotfiles for my daily use

## To link all files

```bash

stow -t ~ kitty nvim zsh

```

### Configure Git

```bash
git config --global commit.gpgsign true
git config --global pull.ff only
gpg --list-secret-keys
git config --global user.signingkey MYKEY
```

#### Tmux setup

```bash

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

```

after install tmux tmp press the following keys

crtl+space and I

- For MacOs do [https://discussions.apple.com/thread/8507324?sortBy=best](https://discussions.apple.com/thread/8507324?sortBy=best)
