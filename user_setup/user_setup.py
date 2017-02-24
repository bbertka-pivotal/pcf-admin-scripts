#!/usr/bin/python
import sys, subprocess

DEFAULT_USER_PASSWORD="workshop"
DEFAULT_ADMIN_PASSWORD="pivotal123!"

def setSpaceRole(email=None, org=None, space=None, role=None):
        if not space and not email and not org and not role:
                return False
        else:
                cmd = "cf set-space-role %s %s %s %s" % (email, org, space, role)
		execute(cmd)
        return True

def setOrgRole(email=None, org=None, role=None):
        if not org and not email and not role:
                return False
        else:
                cmd = "cf set-org-role %s %s %s" % (email, org, role)
		execute(cmd)
        return True

def createUser(email=None, password=None):
        if not email:
                return False
        else:
		if not password:
			password = DEFAULT_USER_PASSWORD
		cmd = "cf create-user %s %s" % (email, password)
		execute(cmd)
        return True

def createOrg(org=None):
        if not org:
                return False
        else:
                cmd = "cf create-org %s -q default" % org
                execute(cmd)
        return True

def execute(cmd=None):
	if not cmd:
		return False
	else:
		print cmd
		proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True)
        	out, err = proc.communicate()
        	if out: print out
		if err: print err


def createSpace(org=None, space=None):
	if not org and not space:
		return False
	else:
                cmd = "cf create-space %s -o %s" % (space, org)
		execute(cmd)
	return True



if __name__=="__main__":
	org = sys.argv[1]
	createOrg(org)
	createSpace(org, "development")	
        createSpace(org, "production")
	createSpace(org, "test")
	with open("orgmanagers.txt") as f:
                for line in f:
                        email = line.strip()
			if not email:
				continue
                        createUser(email=email, password=DEFAULT_ADMIN_PASSWORD)
                        org_roles= ["OrgManager", "BillingManager", "OrgAuditor"]
                        for role in org_roles:
                                setOrgRole(email=email, org=org, role=role)
                        spaces = ['development', 'production', 'test']
                        space_roles= ["SpaceDeveloper", "SpaceManager", "SpaceAuditor"]
			for space in spaces:
	                        for role in space_roles:
        	                        setSpaceRole(email=email, org=org, space=space, role=role)

	with open("developers.txt") as f:
		for line in f:
			email = line.strip()
			if not email:
				continue
			space = email
			try:
				space = email.split("@")[0]
			except:
				print "bad string, reverting to full address"
        		createUser(email=email, password=DEFAULT_USER_PASSWORD)
        		createSpace(org=org, space=space)
                        spaces = ['development', 'production', 'test']
                        space_roles= ["SpaceDeveloper"]
			for s in spaces:
	                        for role in space_roles:
        	                        setSpaceRole(email=email, org=org, space=s, role=role)
                        space_roles= ["SpaceDeveloper", "SpaceManager", "SpaceAuditor"]
                        for role in space_roles:
                        	setSpaceRole(email=email, org=org, space=space, role=role)
