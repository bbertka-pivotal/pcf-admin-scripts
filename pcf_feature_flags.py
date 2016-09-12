#!/usr/bin/python

# https://docs.cloudfoundry.org/adminguide/listing-feature-flags.html

FEATURE_FLAGS = ["user_org_creation",
		"private_domain_creation", 
		"app_bits_upload",
		"app_scaling", 
		"route_creation", 
		"service_instance_creation",
		"diego_docker", 
		"set_roles_by_username", 
		"unset_roles_by_username", 
		"task_creation"]
 
def execute(cmd=None):
	""" General function to execute shell commands """

        if not cmd:
                return False
        else:
                proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True)
                out,err = proc.communicate()
                return out,err

if __name__=="__main__":

	for feature in FEATURE_FLAGS:
		cmd = 'cf enable %s' % feature
		out, err = execute(cmd=cmd)
		if out: print out
		if err: print err
