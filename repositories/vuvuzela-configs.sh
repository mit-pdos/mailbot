url="git@github.com:vuvuzela/configs.git"
configure() {
  git config hooks.mailinglist lazard@csail.mit.edu,nickolai@csail.mit.edu
  git config hooks.emailprefix "[vuvuzela-configs]"
}
