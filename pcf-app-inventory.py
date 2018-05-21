#!/usr/bin/python

# This script uses cf-curl to print an app inventory in the form of (org, space, app-name, buildpack)

import json, subprocess

def cf_curl_json(cmd):
	return json.loads(subprocess.Popen(("cf curl %s | jq '.resources[].entity' | jq --slurp '.'" % cmd), 
					stdout=subprocess.PIPE, shell=True).communicate()[0])

for org, spaces_url in [ (str(org['name']), str(org['spaces_url'])) for org in cf_curl_json("/v2/organizations") ]:
	for org, space, app_url in [ (org, str(space['name']), str(space['apps_url'])) for space in cf_curl_json(spaces_url) ]:
		for app in [ ( org, space, str(a['name']), str(a['buildpack'])) for a in cf_curl_json(app_url) ]:
			print " %s, %s, %s, %s" % app
