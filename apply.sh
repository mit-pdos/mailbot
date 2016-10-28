#!/usr/bin/bash
json="/srv/hooks.json"
secret=$(cat /persist/deploy-secret)

echo "[" > "$json"
for f in *.repo.sh; do
	if [ "$f" = "*.repo.sh" ]; then
		break;
	fi

	name="${f%.repo.sh}"
	path="/srv/git/$name"
	echo "$name" > /dev/stderr

	# .repo file is expected to
	#  - set $url
	#  - define configure() function for git configs
	. "$f"
	if [ -z "$url" ]; then
		echo "no url specified for repo $name -- skipping" > /dev/stderr
		continue;
	fi

	if [ -e "$path" ]; then
		# check that it's in the right state
		if [ ! -d "$path" ]; then
			echo "found non-directory repo checkout at $path" > /dev/stderr
			#rm -rf "$path"
		else
			curl=$(git -C config --get remote.origin.url)
			if [ "$curl" != "$url" ]; then
				echo "$path is a check-out of other url $curl" > /dev/stderr
				#rm -rf "$path"
			fi
		fi
	fi
	if [ ! -e "$path" ]; then
		echo "creating new checkout for $url" > /dev/stderr
		git clone --bare "$url" "$path"
	fi

	# various calls to git config
	pushd "$path" > /dev/null
	export GIT_DIR="$path"
	configure > /dev/stderr
	git config hooks.envelopesender "no-reply@mailbot.pdos.csail.mit.edu"
	popd > /dev/null

	# add to hooks.json
	cat <<EOF
  {
    "id": "email-$name",
    "execute-command": "/bin/mailer",
    "command-working-directory": "/root",
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
