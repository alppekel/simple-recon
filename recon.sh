#!/bin/bash

#####################################################################

# #

# Tested on Debian 11.02-amd64 #

# #

#####################################################################

####################### setting up variables ########################

domainName=$1

# script paths

dir_cloud_enum=~/tools/cloud_enum
dir_assetfinder=~/tools/

#####################################################################

# creating folders and files

fileName=${domainName//.com}

mkdir ~/$fileName
touch ~/$fileName/subdomains.txt
touch ~/$fileName/webservers.txt
mkdir ~/$fileName/urls
mkdir ~/$fileName/cloud_data

#####################################################################

######################## finding subdomains #########################

echo "enumerating subdomains with subfinder"
subfinder -d $domainName -o ~/domains_temp.txt

echo "enumerating subdomains with assetfinder"
cd $dir_assetfinder

./assetfinder -subs-only $domainName >> ~/domains_temp.txt

echo "enumerating subdomains from wildcard domains"
cat ~/domains_temp.txt |grep "*." >> ~/wildcardDomains.txt
cat ~/wildcardDomains.txt | ./assetfinder -subs-only >> ~/domains_temp.txt

echo "removing duplicates and wildcard domains"
sort -u ~/domains_temp.txt | awk '!/\*/' >> ~/$fileName/subdomains.txt

#####################################################################

######################## finding live subdomains ####################

echo "finding live subdomains"
cat ~/$fileName/subdomains.txt | httprobe -c 50 -t 3000 | sort -u >> ~/$fileName/webservers.txt

#####################################################################

######################## enumerating urls ###########################

echo "enumerating urls with getallurls (gau) - this may take some time"
cat ~/$fileName/webservers.txt | gau --threads 5 >> ~/$fileName/urls/gau-urls.txt

#####################################################################

#################### enumerating cloud assets #######################

echo "enumerating with cloud_enum"

python3 $dir_cloud_enum/cloud_enum.py -k $domainName >> ~/$fileName/cloud_data/cloud_enum.txt

#####################################################################

############################# cleanup ###############################

rm ~/wildcardDomains.txt
rm ~/domains_temp.txt
