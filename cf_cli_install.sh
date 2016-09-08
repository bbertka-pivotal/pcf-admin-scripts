#!/bin/sh

# Installs the latest CF CLI

wget -O cf.tgz https://cli.run.pivotal.io/stable?release=linux64-binary&source=github-rel
sleep 5
tar -zxvf ./cf.tgz
chmod 755 cf
mv cf /usr/bin
rm cf.tgz
echo "Done installing CF CLI"
