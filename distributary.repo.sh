url="git@github.com:mit-pdos/distributary.git"
configure() {
	git config hooks.mailinglist jon@thesquareplanet.com
	#git config hooks.announcelist
	#git config hooks.envelopesender
	git config hooks.emailprefix "[soup] "
	#git config hooks.showrev
	#git config hooks.emailmaxlines
	#git config hooks.diffopts
}
