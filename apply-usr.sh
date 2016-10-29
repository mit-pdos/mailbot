#!/usr/bin/bash
json="/srv/hooks.json"
secret=$(cat /persist/deploy-secret)

echo "[" > "$json"
for f in repositories/*.sh; do
	if [ "$f" = "repositories/*.sh" ]; then
		break;
	fi

	name="$(basename "$f")"
	name="${name%.sh}"
	path="/srv/git/$name"
	echo "$name:" > /dev/stderr

	# .repo file is expected to
	#  - set $url
	#  - define configure() function for git configs
	. "$f"
	echo "  $url" > /dev/stderr
	if [ -z "$url" ]; then
		echo "  no url specified -- skipping" > /dev/stderr
		continue;
	fi

	export GIT_DIR="$path"
	if [ -e "$path" ]; then
		# check that it's in the right state
		if [ ! -d "$path" ]; then
			echo "  found non-directory repo checkout at $path" > /dev/stderr
			rm -rf "$path"
		else
			curl=$(git config --get remote.origin.url)
			if [ "$curl" != "$url" ]; then
				echo "  $path is a check-out of other url $curl" > /dev/stderr
				rm -rf "$path"
			fi
		fi
	fi
	if [ ! -e "$path" ]; then
		echo "  creating new checkout for $url" > /dev/stderr
		if ! git clone --bare "$url" "$path"; then
			echo "  failed to check out $url -- skipping" > /dev/stderr
			continue;
		fi
	fi

	# various calls to git config
	pushd "$path" > /dev/null
	git config hooks.diffopts "--patch-with-stat --summary --find-copies-harder"
	git config hooks.emailmaxlines 10000
	configure > /dev/stderr
	git config hooks.envelopesender "$name mailbot <no-reply@mailbot.pdos.csail.mit.edu>"
	popd > /dev/null

	# add to hooks.json
	cat <<EOF
  {
    "id": "email-$name",
    "execute-command": "/usr/bin/mailer",
    "command-working-directory": "/home/default",
    "include-command-output-in-response": true,
    "pass-arguments-to-command":
    [
      {
        "source": "string",
        "name": "$path"
      },
      {
        "source": "payload",
        "name": "ref"
      },
      {
        "source": "payload",
        "name": "before"
      },
      {
        "source": "payload",
        "name": "after"
      },
      {
        "source": "payload",
        "name": "pusher.name"
      },
      {
        "source": "payload",
        "name": "pusher.email"
      },
      {
        "source": "entire-headers"
      }
    ],
    "trigger-rule":
    {
      "and":
      [
        {
          "match":
          {
            "type": "payload-hash-sha1",
            "secret": "$secret",
            "parameter":
            {
              "source": "header",
              "name": "X-Hub-Signature"
            }
          }
        }
      ]
    }
  }
EOF
	echo ","
done >> "$json"

# remove last comma, because javascript
sed -i '$ d' "$json"

# this is a list
echo "]" >> "$json"

# restart webhook
pkill -USR1 webhook
