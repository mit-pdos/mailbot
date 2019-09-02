url="git@github.com:mit-pdos/6.826.git"
configure() {
    git config hooks.mailinglist tchajed@mit.edu,nickolai@csail.mit.edu,atalay@mit.edu
    git config hooks.emailprefix "[6.826]"
}
