#!/bin/sh

# This script adds a new admin user
# Requires uaa.admin_client_credentials

export RAILS_ENV=production

alias uaac='BUNDLE_GEMFILE=/home/tempest-web/tempest/web/vendor/uaac/Gemfile bundle exec uaac'

uaac token client get admin

read -p "Enter new privilaged Username: " username
read -p "Enter new privilaged Password: " password
read -p "Enter new provilaged email: " email

uaac user add $username -p $password --emails $email

uaac member add cloud_controller.admin $username
uaac member add uaa.admin $username
uaac member add scim.read $username
uaac member add scim.write $username
