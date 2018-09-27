# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# mode must be set before we set the theme
# or we get the default
POWERLEVEL9K_MODE='nerdfont-complete'
ZSH_THEME="powerlevel9k/powerlevel9k"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

detect_os() {
  if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
  elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
  elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
  elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
  else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
  fi
}
detect_os

# Set config that applies to all Linux dists
linux_config(){
    # add some color
    alias grep='grep --color=auto'
    alias diff='diff --color=auto'
    export LESS=-R
    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

    man() {
        LESS_TERMCAP_md=$'\e[01;31m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[01;44;33m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[01;32m' \
        command man "$@"
    }
    # https://github.com/andsens/homeshick
    export HOMESHICK_DIR=$HOME/.homesick/repos/homeshick
    source "$HOME/.homesick/repos/homeshick/homeshick.sh"
    fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
}

UNIVERSAL_PLUGINS='command-not-found docker extract gem git git-extras github go python screen vscode'
case "$OS" in
  Darwin)
    plugins=($UNIVERSAL_PLUGINS brew osx)
    ;;
  'Arch Linux')
    plugins=($UNIVERSAL_PLUGINS archlinux terminator gnu-utils)
    linux_config
    ;;
  'Debian GNU/Linux'|Ubuntu)
    plugins=($UNIVERSAL_PLUGINS debian gnu-utils)
    linux_config
    ;;
  OpenBSD)
    plugins=($UNIVERSAL_PLUGINS gnu-utils)
    # https://github.com/andsens/homeshick
    export HOMESHICK_DIR=$HOME/.homesick/repos/homeshick
    source "$HOME/.homesick/repos/homeshick/homeshick.sh"
    fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
    ;;
esac

# Aliases
# Use python3 rather than the system python, which is often still python2
alias python='python3'
alias pydoc='pydoc3'
alias pip='pip3'
# use neovim
alias vim='nvim'
alias vi='nvim'

source $ZSH/oh-my-zsh.sh

# configure powerlevel9k prompt
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh os_icon dir_writable dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator nvm time)

# Get the timezone for the prompt
# This is nice because some servers use UTC, but
# I'm usually on PST or PDT for my desktops
TZONE=$(date +%Z)
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S} $TZONE"
POWERLEVEL9K_OS_ICON_BACKGROUND="white"
POWERLEVEL9K_OS_ICON_FOREGROUND="blue"
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"

export EDITOR=nvim
export VISUAL=$EDITOR
