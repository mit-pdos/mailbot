url="git@github.com:mit-pdos/cspec.git"
configure() {
    git config hooks.mailinglist tchajed@mit.edu,kaashoek@mit.edu,nickolai@csail.mit.edu,adamc@csail.mit.edu
    git config hooks.emailprefix "[cspec]"
}
