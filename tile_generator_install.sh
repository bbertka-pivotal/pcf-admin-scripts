#/bin/sh

#Installs Tile Generator

# note, do not run this as Sudo
# be sure you install python dependencies as user


git clone https://github.com/cf-platform-eng/tile-generator.git
cd tile-generator

# create meatdata for using the PCF Ops Man Utility
touch metadata
echo "---" >> metadata
echo "opsmgr:" >> metadata
echo "    url: https://opsman.your-company.com" >> metadata
echo "    username: admin" >> metadata
echo "    password: password" >> metadata

# if this fails, make sure to install everything as local user
pip install -r requirements.txt --user

echo "export PATH=`pwd`/bin:$PATH" >> ~/.profile

source ~/.profile

# test the utilities
which tile
which pcf

echo "Done.  Please update ./metadata with your ops man creds"
