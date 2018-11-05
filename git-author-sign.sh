#!/bin/sh

# Rewrite git history, fixing the author on old commits and
# re-signing all old commits

git filter-branch --env-filter '

OLD_EMAIL="="
CORRECT_NAME="Travis Cole"
CORRECT_EMAIL="11240+kelp@users.noreply.github.com"

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags

# Re-sign all the commits
git rebase --exec 'git commit --amend --no-edit -n -S' -i --root

# force push upstream
git push --force --tags origin 'refs/heads/*'
