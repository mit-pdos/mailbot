#!/usr/bin/bash
repo="$1"
ref="$2"
before="$3"
after="$4"
pusher="$5"
email="$6"

export GIT_DIR="$repo"
cd "$repo"
git fetch --all

# todo: migrate to multimail?
# https://github.com/git/git/blob/master/contrib/hooks/multimail/README.migrate-from-post-receive-email
echo "$before" "$after" "$ref" | /usr/bin/gitmail "$pusher <$email>"
