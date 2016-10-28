#!/bin/sh
wget -O gitmail https://raw.githubusercontent.com/git/git/master/contrib/hooks/post-receive-email
patch -Np1 gitmail post-receive-email.patch
mv gitmail /usr/bin/gitmail
chmod +x /usr/bin/gitmail

sudo -u archlinux ./apply-usr.sh "$@"
