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
export GITHUB_TOKEN=<github token here>

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

echo "enumerating subdomains with jldc.me"
#https://github.com/KingOfBugbounty/KingOfBugBountyTips
curl -s "https://jldc.me/anubis/subdomains/$domainName" | grep -Po "((http|https):\/\/)?(([\w.-]*)\.([\w]*)\.([A-z]))\w+" >> ~/domains_temp.txt

echo "enumerating subdomains from github"
github-subdomains -d $domainName -o ~/$fileName/github-domains.txt
cat ~/$fileName/github-domains.txt >> ~/domains_temp.txt

echo "removing duplicates and wildcard domains"
sort -u ~/domains_temp.txt | awk '!/\*/' >> ~/$fileName/subdomains.txt

#####################################################################

######################## finding live subdomains ####################

echo "finding live subdomains"
cat ~/$fileName/subdomains.txt | httprobe -c 50 -t 3000 | sort -u >> ~/$fileName/webservers.txt

#####################################################################

echo "enumerating subdomains using gospider"

#https://github.com/KingOfBugbounty/KingOfBugBountyTips
gospider -d 0 -S ~/$fileName/webservers.txt -c 5 -t 100 -d 5 --blacklist jpg,jpeg,gif,css,tif,tiff,png,ttf,woff,woff2,ico,pdf,svg,txt | grep -Eo '(http|https)://[^/"]+' | anew ~/$fileName/scrapped_domains.txt

cat ~/$fileName/scrapped_domains.txt | grep $fileName >> ~/$fileName/scrapped_domains_$domainName.txt


######################## enumerating urls ###########################

echo "enumerating urls with getallurls (gau) - this may take some time"
cat ~/$fileName/webservers.txt | gau --blacklist png,jpg,jpeg,svg,gif,woff,woff2,eot,otf,ttf,css,pdf --threads 100 >> ~/$fileName/urls/gau-urls.txt

#####################################################################

#################### enumerating cloud assets #######################

echo "enumerating with cloud_enum"

python3 $dir_cloud_enum/cloud_enum.py -k $domainName >> ~/$fileName/cloud_data/cloud_enum.txt

#####################################################################

#################### generating zip file #######################

echo "compressing files to zip"

apt-get install zip -y
zip -r ~/$fileName.zip ~/$fileName

#####################################################################

############################# cleanup ###############################

rm ~/wildcardDomains.txt
rm ~/domains_temp.txt
unset GITHUB_TOKEN
echo "done"
