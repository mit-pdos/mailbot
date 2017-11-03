url="git@github.com:n1v0lg/salmon.git"
configure() {
  git config hooks.mailinglist malte@csail.mit.edu,nikolaj@bu.edu,bengetch@gmail.com
  git config hooks.emailprefix "[salmon]"
}
