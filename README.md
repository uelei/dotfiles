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
git config --global user.signingkey MYKEY
```
