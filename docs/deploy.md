The deploy user should have sudoers access to restart the server and copy a new deployment to the correct folders: 

# Sudoers config
`/etc/sudoers.d/signbank`, where `deploy` is the user you use for `STAGING_REMOTE_USER`.
```
%deploy ALL= NOPASSWD: /bin/systemctl daemon-reload
%deploy ALL= NOPASSWD: /bin/systemctl start signbank
%deploy ALL= NOPASSWD: /bin/systemctl stop signbank
%deploy ALL= NOPASSWD: /bin/systemctl restart signbank
%deploy ALL= NOPASSWD: /bin/mv /opt/signbank/*.service /etc/systemd/system --force
```

# CI secrets

- `STAGING_REMOTE_HOST`: IP address of the server, must be provisioned manually
- `STAGING_REMOTE_USER`: the deploy username, must exist on the host already (we use `deploy`)
- `STAGING_SSH_PRIVATE_KEY`: full private key that is already authorized to SSH into the server
- `STAGING_REMOTE_TARGET`: home directory of the deploy user


The database set by `DATABASE_URL` in `signbank.conf` should already exist before the first deploy.