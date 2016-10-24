#!/bin/sh

# change sshd_config
if [ -f "/etc/ssh/sshd_config" ]; then
    sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/^PasswordAuthentication\s+.*/PasswordAuthentication no/' /etc/ssh/sshd_config \
    && sed -ri 's/^HostKey\s+.*//g' /etc/ssh/sshd_config
fi

# prepare run dir
if [ ! -d "/var/run/sshd" ]; then
    mkdir -p /var/run/sshd
fi

# prepare root ssh folder
if [ ! -d "/root/.ssh/" ]; then
    mkdir -p /root/.ssh/ && chmod 700 /root/.ssh/
fi

# prepare ansible ssh keys
if [ -f "/data/ssh/id_ansible_rsa" ]; then
    cp /data/ssh/id_ansible_rsa /root/.ssh/id_rsa \
    && chmod 600 /root/.ssh/id_rsa \
    && echo "HostKey /root/.ssh/id_rsa" >> /etc/ssh/sshd_config
fi

if [ -f "/data/ssh/id_ansible_rsa.pub" ]; then
    cp /data/ssh/id_ansible_rsa.pub /root/.ssh/id_rsa.pub
fi

# prepare authorized_keys
if [ -f "/data/ssh/id_local_rsa.pub" ]; then
    cp /data/ssh/id_local_rsa.pub /root/.ssh/authorized_keys
fi

# prepare known_hosts
if [ -f "/data/ssh/known_hosts" ]; then
    cp /data/ssh/known_hosts /root/.ssh/known_hosts
fi

# prepare ansible
if [ -d "/data/ansible" ]; then
    cp -r /data/ansible /etc/
fi

# export PATH
# export PATH=/usr/src/app/env/bin/:$PATH

exec "$@"
