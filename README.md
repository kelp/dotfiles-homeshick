# dotfiles

Layout of my homeshick castles:

* x11-common x11, and app configs that are common across systems
* dotfiles, this entry point, bootstrap homeshick, shell and git configs
* i3wm, maybe move to x11-common
* redshift, maybe move to x11-common
* termite, maybe move to x11-common or host specific
* x11-arch-pc, x11 configs specific to my desktop pc
* x11-matebook-x-pro, x11 conigs specific to my matebook

Bootstrap with:

```
$ bash <(curl https://raw.githubusercontent.com/kelp/dotfiles/master/boot.sh)
```

This is the entry point that will pull in several 
[homeshick](https://github.com/andsens/homeshick) castles, and some other 
bootstrapping. This is also a homeshick castle that contains my zsh configs
and a few other misc things, like my git config.

It will first try to install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

Then [homeshick](https://github.com/andsens/homeshick)

It assumes a few things have already been installed:

zsh
neovim
python-neovim
git
gpg
hack-nerd-font
