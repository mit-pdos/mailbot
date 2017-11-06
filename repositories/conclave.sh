url="git@github.com:multiparty/conclave.git"
configure() {
  git config hooks.mailinglist malte@csail.mit.edu,nikolaj@bu.edu,bengetch@gmail.com
  git config hooks.emailprefix "[conclave]"
}
