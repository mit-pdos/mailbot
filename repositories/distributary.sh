url="git@github.com:mit-pdos/distributary.git"
configure() {
    git config hooks.mailinglist malte@csail.mit.edu,kaashoek@mit.edu,rtm@csail.mit.edu
    git config hooks.emailprefix "[distributary]"
}
