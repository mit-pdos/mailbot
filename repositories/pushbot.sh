url="git@github.com:mit-pdos/pushbot.git"
configure() {
	git config hooks.mailinglist jon@tsp.io
	git config hooks.emailprefix "[pushbot]"
}
