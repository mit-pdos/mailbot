url="git@github.com:mit-pdos/mailbot.git"
configure() {
	git config hooks.mailinglist jon@tsp.io
	git config hooks.emailprefix "[mailbot]"
	#git config hooks.announcelist
	#git config hooks.showrev
	#git config hooks.emailmaxlines
	#git config hooks.diffopts
}
