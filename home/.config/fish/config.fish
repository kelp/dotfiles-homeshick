# kelp's Fish Config
#

# Config for only interactie shells
if status --is-interactive
    # Bootstrap fisher https://github.com/jorgebucaran/fisher
    if not functions -q fisher
        set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
        curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
        echo "fisher installed, you may need to restart this shell to use it"
    end

    if [ -f $HOME/.work/work.fish ]
        source $HOME/.work/work.fish
    end

    # Gnu dircolors doesn't detect alacritty as a color terminal
    # https://github.com/jwilm/alacritty/issues/2210
    if [ $TERM = "alacritty" ]
        set -x COLORTERM truecolor
    end

    # I often run neofetch from here on remote servers, which will break
    # non-interactive things. Must be run only in non-interactive shells.
    if [ -f $HOME/.config/fish/local.config.fish ]
        source $HOME/.config/fish/local.config.fish
    end

    # Aliases
    alias vi="nvim"
    alias view="nvim -R"

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

    function gpgagent
        set -gx GPG_TTY (tty)
        if [ $argv[1] = "Linux" ]
            gpgconf --create-socketdir
        end
        gpg-connect-agent -q updatestartuptty /bye > /dev/null 
    end

    # I have a local motd generated by a systemd timer or a cron as my user
    # if it exists, we'll cat it on interactive login shells.
    function motd
        if status is-interactive && status is-login
            set MOTD $HOME/.config/motd/motd
            if [ -f $MOTD ]
                cat $MOTD
            end
        end
    end

    # OS specific Configs 
    set -x OS (uname -s)

    switch $OS
        case Linux
            if set -q DESKTOP_SESSION
                set -gx SSH_AUTH_SOCK (gnome-keyring-daemon --start | awk -F "=" '$1 == "SSH_AUTH_SOCK" { print $2 }')
            end
            if [ -n "$SSH_CONNECTION" ]
                set -x PINENTRY_USER_DATA "USE_CURSES=1"
            end
            motd 
            gpgagent $OS
        case OpenBSD
            alias pip='pip3.6'
            alias tar='gtar'
            alias ls='gls --color'
            set -x TERM xterm-color
        case Darwin
            gpgagent $OS
        case '*'
            echo "I don't know what OS this is"
    end

    # https://github.com/andsens/homeshick/ manages my dotfiles
    source "$HOME/.homesick/repos/homeshick/homeshick.fish"
    source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"
    set -x EDITOR "nvim"
    set -x VISUAL "$EDITOR"
    set -x MYVIMRC "$HOME/.config/nvim/init.vim"
    set -x ELECTRON_TRASH "trash-cli code"

    set -x npm_config_prefix $HOME/.node_modules

end

# Global configs for interactive and non-interactive shells
set -x GOPATH "$HOME/src"

if [ -d $HOME/.node_modules/bin ]
    set -x PATH $HOME/bin $HOME/.node_modules/bin /usr/local/sbin $PATH
else
    set -x PATH $HOME/bin $GOPATH/bin /usr/local/sbin $PATH
end

# Global aliases
alias python="python3"
alias pip="pip3"
alias pydoc="pydoc3"
