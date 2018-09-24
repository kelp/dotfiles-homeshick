# Customize to your needs... 
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin 
case "$(uname)" in
  Darwin)
#  export GOROOT=/usr/local/Cellar/go/1.10.2
  #export GOPATH=$HOME/dev/go
#  export PATH=$PATH:$GOROOT/bin
  export GOPATH=$HOME/dev
  alias robo='robo --config $GOPATH/src/github.com/segmentio/robofiles/development/robo.yml'

  export SEGMENT_TEAM=foundation
  export ATLAS_TOKEN='hQTtyMRIvI9Jxg.atlasv1.mvETQ70aKmwwv6RVZFJKizyOQfXyJXGw3GSPMO35MWe3OYmBwkyzyR037rU8hILK9gM'

  export PATH=$HOME/bin:$HOME/Library/Python/3.7/bin:$PATH
  source ~/dev/src/github.com/segmentio/dotfiles/index.sh
    ;;
  Linux)
    ;;
  *)
esac
