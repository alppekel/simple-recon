#!/bin/bash

#!/bin/bash

#####################################################################

# #

# Tested on Debian 11.02-amd64 #

# #

#####################################################################

####################### setting up variables ########################

domainName=$1

# script paths

dir-ctfr=~/tools/py-scripts
dir-cloud_enum=~/tools/cloud_enum
dir-s3scanner=~/tools/S3Scanner

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

python3 $dir-ctfr/ctfr.py -d $domainName -o domains_temp.txt

# enumerating subdomains with subfinder

subfinder -d $domainName -o domains_temp.txt

# enumerating subdomains with assetfinder

./assetfinder -subs-only $domainName >> domains_temp.txt

# enumerating subdomains from wildcard domains

cat domains_temp.txt |grep "*." >> wildcardDomains.txt
cat wildcardDomains.txt | ./assetfinder -subs-only >> domains_temp.txt

# cleanup - removing duplicates and wildcard domains

sort -u domains_temp.txt | awk '!/\*/' >> subdomains.txt
rm domains_temp.txt

#####################################################################

######################## enumerating github #########################

github-subdomains -d $domainName -t >> ~/$domainName/github-data.txt

#####################################################################

######################## finding live subdomains ####################

cat subdomains.txt | httprobe -c 50 -t 3000 | sort -u >> webservers.txt

#####################################################################

######################## enumerating urls ###########################

# enumerating urls from waybackdata

cat webservers.txt | waybackurls >> $domainName/waybackdata/waybackurl.txt

#####################################################################

#################### enumerating cloud assets #######################

# enumeration with cloud_enum

python3 $dir-cloud_enum/cloud_enum.py -k $domainName >> touch ~/$domainName/urls/waybackdata/cloud_enum.txt

# enumerating buckets

python3 $dir-s3scanner/s3scanner.py -l subdomains.txt -o ~/$domainName/cloud_data/buckets.txt



