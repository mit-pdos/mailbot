url="git@github.com:mit-pdos/tej-mailbot-test.git"
configure() {
    git config hooks.mailinglist tchajed@mit.edu
    git config hooks.emailprefix "[tej-mailbot-test]"
}
