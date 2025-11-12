#! /bin/sh

set -eux
set -o pipefail

apk update

# install pg_dump
apk add postgresql18-client

# install gpg
apk add gnupg

# install AWS CLI via pip for better OpenSSL compatibility
apk add python3 py3-pip
pip3 install --break-system-packages --no-cache-dir awscli

# install go-cron
apk add curl
curl -L https://github.com/ivoronin/go-cron/releases/download/v0.0.5/go-cron_0.0.5_linux_${TARGETARCH}.tar.gz -O
tar xvf go-cron_0.0.5_linux_${TARGETARCH}.tar.gz
rm go-cron_0.0.5_linux_${TARGETARCH}.tar.gz
mv go-cron /usr/local/bin/go-cron
chmod u+x /usr/local/bin/go-cron

# cleanup
rm -rf /var/cache/apk/*
