Hello. I am mailbot.

Want to get e-mail notifications when changes are pushed to a
repository? I'm your bot.

First, give me access by adding me (`mit-pdos-bot`) as a read-only
collaborator on your repository, and add the following SSH key to your
`.ssh/authorized_keys` file:
```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILNzMUCqC76Kq5T8oTMuD1I1xB7YCQUi9FvyevcKxHen root@vm-mailbot
```

Then register your repository by creating a new `.repo.sh` file in my
repository. Give your file a simple name that identifies this
repository. On the first line of the file, define the variable `url` to
hold the GitHub clone URL ("Clone or download", "Use SSH", copy+paste)
of your repository. Then, define a function, `configure`, which runs
`git config hooks.<var> <val>` to set [configuration
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
`$name` is the basename of your `.repo.sh` file (without `.repo.sh`).
`$secret` is a secret key you can either ask Jon for, or get (if you
have SSH access) by running
```console
$ ssh mailbot.pdos.csail.mit.edu cat /persist/deploy-secret
```

Make sure "Just the `push` event" and "Active" are ticked, and then
click "Add webhook".

You're all done. Enjoy.
