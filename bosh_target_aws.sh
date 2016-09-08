#!/bin/sh

export RAILS_ENV=production

alias bosh='BUNDLE_GEMFILE=/home/tempest-web/tempest/web/vendor/bosh/Gemfile bundle exec bosh'
alias uaac='BUNDLE_GEMFILE=/home/tempest-web/tempest/web/vendor/uaac/Gemfile bundle exec uaac'

uaac target --ca-cert /var/tempest/workspaces/default/root_ca_certificate https://10.0.16.10:8443
bosh --ca-cert /var/tempest/workspaces/default/root_ca_certificate target 10.0.16.10
bosh status
