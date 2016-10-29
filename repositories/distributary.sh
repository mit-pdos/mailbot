url="git@github.com:mit-pdos/distributary.git"
configure() {
    git config hooks.mailinglist malte@csail.mit.edu,nikhil.benesch@gmail.com,kaashoek@mit.edu
    git config hooks.emailprefix "[distributary]"
}
