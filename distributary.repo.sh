url="git@github.com:mit-pdos/distributary.git"
configure() {
	git config hooks.mailinglist soup@pdos.csail.mit.edu
	#git config hooks.announcelist
	#git config hooks.envelopesender
	git config hooks.emailprefix "[soup] "
	#git config hooks.showrev
	#git config hooks.emailmaxlines
	#git config hooks.diffopts
}
