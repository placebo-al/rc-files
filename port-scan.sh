#!/bin/bash

if [ $# -ne 1 ] ; then
  echo "Usage: remember to add the url"
  exit
fi

box=$1
echo "Scanning for open ports on $victim "

nmap -Pn -sS -p- --open -T4 --min-rate=1000 $box -oN ${box}

ports=$(cat ${box} | grep open | cut -d " " -f 1 | cut -d "/" -f 1 | tr "\n" "," | cut -c3- | head -c-2)

echo "Now scanning $ports on $box"

nmap -Pn -p $ports -sCV --script=default $box -oN ${box}-nmap
