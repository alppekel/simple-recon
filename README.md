# simple-recon

# Description

Tested on Debian 11.02 amd64

This script use various open source tools to perform reconnaissance on a given domain.

The tools used are:

1) <a href="https://github.com/UnaPibaGeek/ctfr">ctfr</a>
2) <a href="https://github.com/projectdiscovery/subfinder">subfinder</a>
3) <a href="https://github.com/tomnomnom/assetfinder">assetfinder</a>
4) <a href="https://github.com/gwen001/github-subdomains">github-subdomains</a>
5) <a href="https://github.com/tomnomnom/httprobe">httprobe</a>
6) <a href="https://github.com/tomnomnom/waybackurls">waybackurls</a>
7) <a href="https://github.com/initstring/cloud_enum">cloud_enum</a>
8) <a href="https://github.com/sa7mon/S3Scanner">S3Scanner</a>

You can also use my <a href="https://github.com/alppekel/bugbounty-recon-tools">recon-tools</a> script to automatically install required tools.

# Usage

You need to run this script as root or with sudo.

Change "script paths" section
```
####################### setting up variables ########################

domainName=$1

# script paths

dir-ctfr=~/tools/py-scripts
dir-cloud_enum=~/tools/cloud_enum
dir-s3scanner=~/tools/S3Scanner
dir-assetfinder=~/tools/

#####################################################################
```

Usage:
```
chmod +x install.sh;./install.sh <target-domain>
```

Script save results in following format:
```
todo!!
```
