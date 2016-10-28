url="https://github.com/mit-pdos/fscq-impl.git"
configure() {
	git config hooks.mailinglist fscq@pdos.csail.mit.edu
	#git config hooks.announcelist
	#git config hooks.envelopesender
	git config hooks.emailprefix "[fscq] "
	#git config hooks.showrev
	#git config hooks.emailmaxlines
	#git config hooks.diffopts
}
