url="git@github.com:vuvuzela/website.git"
configure() {
  git config hooks.mailinglist lazard@csail.mit.edu,nickolai@csail.mit.edu
  git config hooks.emailprefix "[vuvuzela-website]"
}
