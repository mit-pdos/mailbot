#!/bin/sh
wget --quiet -O gitmail https://raw.githubusercontent.com/git/git/master/contrib/hooks/post-receive-email
patch -Np1 gitmail post-receive-email.patch
mv gitmail /usr/bin/gitmail
chmod +x /usr/bin/gitmail

if ! id archlinux; then
	echo "still in setup mode -- running apply-usr as root"
	./apply-usr.sh "$@"
	exit $?
fi

sudo -u archlinux ./apply-usr.sh "$@"
