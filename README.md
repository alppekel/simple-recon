# simple-recon

# Description

Tested on Debian 11.02 amd64

This script use various open source tools to perform reconnaissance on a given domain.

The tools used are:

1) <a href="https://github.com/projectdiscovery/subfinder">subfinder</a>
2) <a href="https://github.com/tomnomnom/assetfinder">assetfinder</a>
3) <a href="https://github.com/tomnomnom/httprobe">httprobe</a>
4) <a href="https://github.com/lc/gau">getallurls (gau)</a>
5) <a href="https://github.com/jaeles-project/gospider">gospider</a>
6) <a href="https://github.com/initstring/cloud_enum">cloud_enum</a>
7) <a href="https://github.com/gwen001/github-subdomains">github-subdomains</a>
8) <a href="https://github.com/tomnomnom/anew">anew</a>

You can also use my <a href="https://github.com/alppekel/bugbounty-recon-tools">recon-tools</a> script to automatically install required tools.

# Usage

You need to run this script as root.

Change "script paths" section.
```
####################### setting up variables ########################

domainName=$1

# script paths

dir_cloud_enum=~/tools/cloud_enum
dir_assetfinder=~/tools/
export GITHUB_TOKEN=<github token here>

#####################################################################
```

Usage:
```
chmod +x install.sh;./install.sh <target-domain>
```
