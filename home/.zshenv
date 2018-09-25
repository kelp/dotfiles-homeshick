# Customize to your needs... 
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin 

# Employeer specific configs go here
if [ -f $HOME/.work/workrc ]; then
  source $HOME/.work/workrc
fi

case "$(uname)" in
  Darwin)
  # If we don't set this, git commit will use OS X's old vim version that
  # breaks SpaceVim
  export EDITOR=nvim
  export GOPATH=$HOME/dev

  export PATH=$HOME/bin:$HOME/Library/Python/3.7/bin:$PATH
    ;;
  Linux)
    ;;
  *)
esac
