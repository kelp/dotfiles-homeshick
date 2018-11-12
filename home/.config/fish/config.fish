# Fish Config
#
# Bootstrap fisher https://github.com/jorgebucaran/fisher
if not functions -q fisher; and status --is-interactive
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    echo "fisher installed, you may need to restart this shell to use it"
end

# Plugins I may need to use:
# https://github.com/oh-my-fish/plugin-local-config

set -g theme_powerline_fonts yes
set -g theme_nerd_fonts yes
set -g theme_display_user ssh
set -g theme_display_hostname ssh
set -g theme_show_exit_status yes
set -g theme_color_scheme dark
set -g fish_prompt_pwd_dir_length 4
set -g theme_project_dir_length 1
set -g theme_newline_cursor no

set -g theme_title_display_process yes
set -g theme_title_display_path yes
set -g theme_title_display_user no
set -g theme_title_use_abbreviated_path no

set TZONE (date +%Z)
set -g theme_date_format "+%H:%M:%S:$TZONE"

# disable the theme greeting
function fish_greeting
    uptime
    set_color normal
end

# Initialize the keycghain plugin
# https://github.com/jitakirin/pkg-keychain
set -U keychain_init_args --quiet --agents ssh,gpg --inherit local

set -x EDITOR "nvim"
set -x VISUAL "$EDITOR"
set -x MYVIMRC "$HOME/.config/nvim/init.vim"
set -x GOPATH "$HOME/src"

alias vi="nvim"
alias view="nvim -R"

alias python="python3"
alias pip="pip3"
alias pydoc="pydoc3"

# https://github.com/andsens/homeshick/ manages my dotfiles
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"

