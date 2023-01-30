#!/bin/bash

#!/bin/bash

#####################################################################

# #

# Tested on Debian 11.02-amd64 #

# #

#####################################################################

# Setting up variables

domainName=$1




#####################################################################

# creating folders and files

mkdir ~/$domainName
touch ~/$domainName/subdomains.txt
touch ~/$domainName/webservers.txt
touch ~/$domainName/github-data.txt
mkdir ~/$domainName/urls
mkdir ~/$domainName/urls/waybackdata
touch ~/$domainName/urls/waybackdata/waybackurls.txt
mkdir ~/$domainName/cloud_data
touch ~/$domainName/urls/waybackdata/cloud_enum.txt
touch ~/$domainName/urls/waybackdata/s3scanner-buckets.txt

#####################################################################

######################## finding subdomains #########################

# enumerating subdomains with ctfr.py

python3 
