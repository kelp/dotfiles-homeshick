# Fish Config
#
# Bootstrap fisher https://github.com/jorgebucaran/fisher
if not functions -q fisher; and status --is-interactive
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    echo "fisher installed, you may need to restart this shell to use it"
end

if [ -f $HOME/.work/work.fish ]
    source $HOME/.work/work.fish
end

if [ -f $HOME/.config/fish/local.config.fish ]
    source $HOME/.config/fish/local.config.fish
end

# bobthefish settings https://github.com/oh-my-fish/theme-bobthefish
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
    set_color normal
end

# Initialize the keycghain plugin
# https://github.com/jitakirin/pkg-keychain
#if status --is-interactive
#    set -U keychain_init_args --quiet --agents ssh,gpg --inherit local id_rsa F1C6003020E496A1BAEC71CA67E4246BD03CB8A7
#end

# Aliases
alias vi="nvim"
alias view="nvim -R"

alias python="python3"
alias pip="pip3"
alias pydoc="pydoc3"

function gpgagent
    set -gx GPG_TTY (tty)
    gpg-connect-agent updatestartuptty /bye > /dev/null 
end

# OS specific Configs 
set -x OS (uname -s)

switch $OS
    case Linux
        if set -q DESKTOP_SESSION
            set -gx SSH_AUTH_SOCK (gnome-keyring-daemon --start | awk -F "=" '$1 == "SSH_AUTH_SOCK" { print $2 }')
            gpgagent
        end
    case OpenBSD
        alias pip='pip3.6'
        alias tar='gtar'
        alias ls='gls'
        set -x TERM xterm-color
    case Darwin
        gpgagent
    case '*'
        echo "I don't know what OS this is"
end

set -x EDITOR "nvim"
set -x VISUAL "$EDITOR"
set -x MYVIMRC "$HOME/.config/nvim/init.vim"
set -x GOPATH "$HOME/src"

set -x npm_config_prefix $HOME/.node_modules

if [ -d $HOME/.node_modules/bin ]
    set -x PATH $HOME/bin $HOME/.node_modules/bin /usr/local/sbin $PATH
else
    set -x PATH $HOME/bin /usr/local/sbin $PATH
end
# set -x GTK_THEME Adapta

if [ -f $HOME/.work/work.fish ]
    source $HOME/.work/work.fish
end

# https://github.com/andsens/homeshick/ manages my dotfiles
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"

