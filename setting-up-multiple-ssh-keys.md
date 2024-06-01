# Setting up multiple SSH keys on one computer

1. Change directory into SSH key is in `~/.ssh`
2. Generate 2 keys: `ssh-keygen -t rsa -C "email"`  (second key will try to overwrite, give it another name)
3. Create config in `~/.ssh/config` with the following content: 

```yml

Host gitlab.com-erudinsky
     HostName gitlab.com
     PreferredAuthentications publickey
     IdentityFile ~/.ssh/id_rsa

# personal                                                                                                                                                
Host gitlab.com-evgenyrudinsky
     HostName gitlab.com
     PreferredAuthentications publickey
     IdentityFile ~/.ssh/id_rsa_personal

```

4. Add keys to your GitHub/GitLab/ADO/YourChoice platform
5. If run into "Too Open" permissions issue, fix: `chmod 600 ~/.ssh/id_rsa`
6. Clone the repo replacing base url with what is in the `Host` value, like this:

Original: `git@github.com:erudinsky/cheat-sheets.git`
New: `git@gitlab.com-erudinsky:erudinsky/cheat-sheets.git`

gitlab.com <=> gitlab.com-erudinsky

This should be then stored in `.git/config` file of the repo and next time when you do `git pull` or `git push` or any other operations with repo it should just work picking correct private key to match the public key on the git server!