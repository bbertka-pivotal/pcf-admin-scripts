#! /usr/bin/python

# cf-user-acl.py - Saves a CSV file of users with their org access
# usage: python cf-user-acl.py [acl.csv]
# Note, user should be logged in as cf admin

import subprocess
import json
import csv, sys


def execute(cmd=None):
	""" General function to execute shell commands """

        if not cmd:
                return False
        else:
                proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True)
                out,err = proc.communicate()
                return out,err


def writeCSV(acl=None):
	""" Saves the ACL array into a CSV file """

	if not acl:
		return False
	f = open(sys.argv[1], 'wt')
	try:
		writer = csv.writer(f)
		writer.writerow( ('Username', 'Org Access') )
		for item in acl:
			email, orgs = item[0], item[1]
			writer.writerow( ( email, (", ").join(orgs) ) )
	except Exception as e:
		print "writeCSV: exception: %s" % e
	finally:
		f.close()


def getUsers(cmd="v2/users", acl=[]):
	""" Wraps the CF curl command for getting users, recurses through 
	pages of users checing their Org membership, returns User/Org ACL """

	results = execute(cmd="cf curl '%s'" % cmd)
	items = json.loads(results[0])
	next = items['next_url']
	entities = [ i for i in items['resources'] ]
	for item in entities:
		try:
			orgs = getUserOrganizations(cmd=item['entity']['organizations_url'])
			if orgs:
				acl.append( (item['entity']['username'], orgs) )
		except Exception as e:
			print "getUsers: exception: %s" % e
			continue
	if next: getUsers(cmd=next, acl=acl)
	return acl

def getUserOrganizations(cmd=None):
	""" Wraps the CF curl command for getting user Orgs, returns org list """

	if not cmd:
		return False
	results = execute(cmd="cf curl '%s'" % cmd)
        items = json.loads(results[0])
        entities = [ i for i in items['resources'] ]
	orgs = []
        for item in entities:
		orgs.append(str(item['entity']['name']))
	return orgs


if __name__=="__main__":
	writeCSV( getUsers() )
