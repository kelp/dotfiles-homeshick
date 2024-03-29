#!/bin/bash

# bootstrap script to install Homeshick and you preferred castles to a new
# system.

tmpfilename="/tmp/${0##*/}.XXXXXX"

if type mktemp >/dev/null; then
  tmpfile=$(mktemp $tmpfilename)
else
  tmpfile=$(echo $tmpfilename | sed "s/XX*/$RANDOM/")
fi

trap 'rm -f "$tmpfile"' EXIT

cat <<'EOF' > $tmpfile
# Which Homeshick castles do you want to install?
#
# Each line is passed as the argument(s) to `homeshick clone`.
# Lines starting with '#' will be ignored.
#
# If you remove or comment a line that castle will NOT be installed.
# However, if you remove or comment everything, the script will be aborted.

# Plugin management
# gmarik/Vundle.vim
# tmux-plugins/tpm

# Main castles
kelp/dotfiles
kelp/nvim
# Uncomment one of below if on those systems
#kelp/i3status-rs-archbook
#kelp/i3wm
#kelp/redshift
#kelp/x11-arch-matebook
#kelp/x11-common

# Unused
#kelp/termite


# Private castles (commented by default)
#sukima/muttrc
#secret@example.org:securerc.git
EOF

${VISUAL:-vi} $tmpfile

code=$?

if [[ $code -ne 0 ]]; then
  echo "Editor returned ${code}." 1>&2
  exit 1
fi

castles=()

while read line; do
  castle=$(echo "$line" | sed '/^[ \t]*#/d;s/^[ \t]*\(.*\)[ \t]*$/\1/')
  if [[ -n $castle ]]; then
    castles+=("$castle")
  fi
done <$tmpfile

if [[ ${#castles[@]} -eq 0 ]]; then
  echo "No castles to install. Aborting."
  exit 0
fi

if [[ ! -f $HOME/.homesick/repos/homeshick/homeshick.sh ]]; then
  git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
fi

if [[ ! -f $HOME/.oh-my-zsh/custom/themes/powerlevel9k ]]; then
  git clone https://github.com/bhilburn/powerlevel9k.git $HOME/.oh-my-zsh/custom/themes/powerlevel9k
fi

source $HOME/.homesick/repos/homeshick/homeshick.sh

for castle in "${castles[@]}"; do
  homeshick clone "$castle"
done
