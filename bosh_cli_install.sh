#!/bin/sh

# Installs the latest BOSH CLI

sudo apt-get install build-essential ruby ruby-dev libxml2-dev libsqlite3-dev libxslt1-dev libpq-dev libmysqlclient-dev zlib1g-dev
gem install cf-uaac
gem install bosh_cli --no-ri --no-rdoc
which bosh
bosh status
