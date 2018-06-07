#!/usr/bin/sh

# Enables the PKS On-demand Service Broker for use with the PAS Marketplace
#
# Please authenticate with CF CLI as PCF Admin at the command line
# Be sure to have credhub available on system

PKSAPI_ADDR="192.168.50.10"
BOSH_ADDR="192.168.101.10"
BOSH_UAA_ADMIN_PASS="rHN4o0KdH1-wj8ZBOQi3KtHPXvrhtwBK"
ROOT_CA_CERT_PATH="/var/tempest/workspaces/default/root_ca_certificate"

# server value is your Bosh Director VM IP
credhub api --server https://${BOSH_ADDR}:8844 --ca-cert ${ROOT_CA_CERT_PATH}

# user is Bosh Director UAA Admin Credentials
credhub login -u admin -p ${BOSH_UAA_ADMIN_PASS}

BROKERNAME=$(credhub find odb_broker_basicauth | grep odb_broker_basicauth | cut -d ':' -f 2)

CREDS=$(credhub get -n ${BROKERNAME} icauth)

PASSWORD=$(echo ${CREDS} | cut -d ':' -f 6 | cut -d ' ' -f 2)
USERNAME=$(echo ${CREDS} | cut -d ':' -f 8 | cut -d ' ' -f 2)

cf create-service-broker PKS ${USERNAME} ${PASSWORD} http://${PKSAPI_ADDR}:8080
cf enable-service-access p.pks
