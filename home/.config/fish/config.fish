# Fish Config
#

set -g theme_powerline_fonts yes
set -g theme_nerd_fonts yes
set -g theme_display_user ssh
set -g theme_display_hostname ssh
set -g theme_show_exit_status yes
set -g theme_color_scheme dark
set -g fish_prompt_pwd_dir_length 4
set -g theme_project_dir_length 1
set -g theme_newline_cursor no

set TZONE (date +%Z)
set -g theme_date_format "+%H:%M:%S:$TZONE"

# disable the theme greeting
#function fish_greeting
#end

# Initialize the keycghain plugin
# https://github.com/jitakirin/pkg-keychain
set -U keychain_init_args --quiet --agents ssh,gpg --inherit local

set -x EDITOR "nvim"
set -x VISUAL "$EDITOR"
set -x MYVIMRC "$HOME/.config/nvim/init.vim"
set -x GOPATH "$HOME/dev"

alias vi="nvim"
alias view="nvim -R"

alias python="python3"
alias pip="pip3"
alias pydoc="pydoc3"

source "$HOME/.homesick/repos/homeshick/homeshick.fish"
