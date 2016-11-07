#!/usr/bin/bash
repo="$1"
ref="$2"
before="$3"
after="$4"

pusher="$5"
email="$6"
from="$pusher <$email>"

if [[ "$7" = "ping" ]]; then
	echo "pong";
	exit 0
fi

echo "handling $7 to $repo"
echo "$@"
echo "pushed by: $from"

alias=$(grep -E "^$pusher " "/srv/external/wc/mailbot/alias")
#alias=$(grep -E "^$pusher " "./alias")
if [ -n "$alias" ]; then
	# user has a defined alias, use that instead
	alias="${alias#$pusher }"
	# does alias match Name <email> or email?
	if [[ $alias =~ ^.*[[:blank:]]\<.+@.+\..+\>$ ]]; then
		from="$alias"
	elif [[ $alias =~ ^[^[:blank:]]+@[^[:blank:]]+\.[^[:blank:]]+$ ]]; then
		from="$alias"
	else
		echo "Invalid alias '$alias' for username $pusher; ignoring"
	fi
	echo "aliased to $from"
fi

echo "syncing with upstream"
export GIT_DIR="$repo"
cd "$repo"
echo -n '  ' # indent fetch
git fetch origin '*:*'

cat <<EOF
invoking post-receive-email with

  $before
  $after
  $ref

EOF
# todo: migrate to multimail?
# https://github.com/git/git/blob/master/contrib/hooks/multimail/README.migrate-from-post-receive-email
echo "$before" "$after" "$ref" | /usr/bin/gitmail "$from" 2>&1

echo "all done"
