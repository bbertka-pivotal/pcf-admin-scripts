#!/bin/sh

export RAILS_ENV=production

alias bosh='BUNDLE_GEMFILE=/home/tempest-web/tempest/web/vendor/bosh/Gemfile bundle exec bosh'
alias uaac='BUNDLE_GEMFILE=/home/tempest-web/tempest/web/vendor/uaac/Gemfile bundle exec uaac'

bosh stop cloud_controller
bosh stop cloud_controller_worker
bosh stop --hard cloud_controller
bosh stop --hard cloud_controller_worker
bosh stop --hard
