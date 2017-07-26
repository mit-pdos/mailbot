#!/bin/sh

echo "updating mailbot config"

wget --quiet -O gitmail https://raw.githubusercontent.com/git/git/master/contrib/hooks/post-receive-email
patch -Np1 gitmail post-receive-email.patch
mv gitmail /usr/bin/gitmail
chmod +x /usr/bin/gitmail

if ! id arch; then
	echo "still in setup mode -- running apply-usr as root"
	./apply-usr.sh "$@" 2>&1
	exit $?
fi

sudo -u arch ./apply-usr.sh "$@" 2>&1
