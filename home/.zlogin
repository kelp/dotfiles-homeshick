# .zlogin
# sourced by login shells only
# TODO - consider running more often than once a day, since this is fast
#

# checking if the local repo is in sync with remote master
(cd $HOME/src/kelp-config
UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")
)

DATE=`date +%F`
LAST_UPDATE=$HOME/.kelp-config_last_update

# If kelp-config is older than today, update it
if [ -f $LAST_UPDATE ] && [ $(cat $LAST_UPDATE) = $DATE ]; then
    # do nothing
else
    (cd $HOME/src/kelp-config && git remote update)
    if [ $LOCAL = $REMOTE ]; then
        echo "Up to date"
        date +%F > $LAST_UPDATE
    elif [ $LOCAL = $BASE ]; then
        # Update kelp-config
        echo "Updating kelp-config, this will only happen once today"
        (cd $HOME/src/kelp-config && git pull)
        date +%F > $LAST_UPDATE
    fi
fi
