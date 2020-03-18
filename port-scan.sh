#!/bin/bash

if [ $# -ne 1 ] ; then
  echo "Usage: remember to add the url"
  exit
fi

victim=$1
echo "Scanning for open ports on $victim "

nmap -Pn -sS -p- --open -T4 --min-rate=1000 $victim -oN ${victim}

ports=$(cat ${victim} | grep open | cut -d " " -f 1 | cut -d "/" -f 1 | tr "\n" "," | cut -c3- | head -c-2)

echo "Now scanning $ports on $victim"

nmap -Pn -p $ports -sCV --script=default $victim -oN ${victim}-nmap
