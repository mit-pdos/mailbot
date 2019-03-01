url="git@github.com:mit-pdos/noria.git"
configure() {
    git config hooks.mailinglist malte@csail.mit.edu,kaashoek@mit.edu,rtm@csail.mit.edu,samyu@mit.edu
    git config hooks.emailprefix "[noria]"
}
