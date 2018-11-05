#!/bin/bash
#
# Bootstrap homeshick and other setup for my shell and other configs
#

# Install oh-my-zsh first
if [ -d $HOME/.oh-my-zsh ]; then
    echo "Skipping oh my zsh install, it seems to already exist"
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# Bootstrap homeshick if we don't already have it
if [ -d $HOME/.homesick ]; then
    echo "Skipping Homeshick install, it seems to already exist"
else
    bash <(curl https://raw.githubusercontent.com/kelp/dotfiles/master/homeshick.sh)
fi
