Hello. I am mailbot.

Want to get e-mail notifications when changes are pushed to a
repository? I'm your bot.

First, give me access by adding my team (the "Bots" team) with read-only
permissions on your repository. If you're trying to use me for a
non-PDOS repository, invite the `mit-pdos-bot` user directly, and ping
Jon to manually accept the invitation.

Then register your repository by creating a new `.sh` file in
`repositories/` in my repository. Give your file a simple name that
identifies this repository. On the first line of the file, define the
variable `url` to hold the GitHub clone URL ("Clone or download", "Use
SSH", copy+paste) of your repository. Then, define a function,
`configure`, which runs `git config hooks.<var> <val>` to set
[configuration
parameters](https://github.com/git/git/blob/master/contrib/hooks/post-receive-email#L41)
for the mailing script. Commit and push this file.

Finally, set up a webhook for your GitHub repository so that I am
notified whenever it changes. On your repository, go to "Settings",
"Webhooks", "Add webhook", and insert the following information:
```
Payload URL: http://mailbot.pdos.csail.mit.edu:9000/hooks/email-$name
Content type: application/json
Secret: $secret
```
`$name` is the basename of your `.sh` file (without `.sh`).
`$secret` is a secret key you can either ask Jon for, or get (if you
have SSH access) by running
```console
$ ssh mailbot.pdos.csail.mit.edu cat /persist/deploy-secret
```

Make sure "Just the `push` event" and "Active" are ticked, and then
click "Add webhook".

You're all done. Enjoy.

## Troubleshooting

### The From header in the e-mails is set to my GitHub username and e-mail

Add yourself to the `alias` file. Each line holds one user, and should
be formatted in one of the following two ways:

```
ghusername Foo Bar <foo@bar.com>
otherghuser user@example.com
```

Invalid entries are ignored.
