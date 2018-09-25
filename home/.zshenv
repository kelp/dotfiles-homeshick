# Customize to your needs... 
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin 

# Employeer specific configs go here
if [ -f $HOME/.work/workrc ]; then
  source $HOME/.work/workrc
fi

case "$(uname)" in
  Darwin)
  export GOPATH=$HOME/dev

  export PATH=$HOME/bin:$HOME/Library/Python/3.7/bin:$PATH
    ;;
  Linux)
    ;;
  *)
esac
