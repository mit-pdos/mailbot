url="git@github.com:mit-pdos/6.826-labs.git"
configure() {
    git config hooks.mailinglist tchajed@mit.edu,kaashoek@mit.edu,nickolai@csail.mit.edu
    git config hooks.emailprefix "[6.826 Labs]"
}
