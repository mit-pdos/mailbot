url="git@github.com:mit-pdos/githooks.git"
configure() {
	git config hooks.mailinglist jon@tsp.io
	#git config hooks.announcelist
	#git config hooks.envelopesender
	git config hooks.emailprefix "[hooks] "
	#git config hooks.showrev
	#git config hooks.emailmaxlines
	#git config hooks.diffopts
}
