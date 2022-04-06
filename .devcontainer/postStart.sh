# set permissions for ssh keys
chown -R root:root ~/.ssh
chmod 700 ~/.ssh
chmod 600 ~/.ssh/config || true
chmod 600 ~/.ssh/id_rsa || true
chmod 644 ~/.ssh/known_hosts || true
chmod 644 ~/.ssh/is_rsa.pub || true