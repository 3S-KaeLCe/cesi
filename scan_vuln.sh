#!/bin/bash

ipAndMask=(`echo $1 | tr '/', ' '`)
ip=${ipAndMask[0]}
mask=${ipAndMask[1]}
ipArray=(`echo $ip | tr '.', ' '`)

if [ $mask -ge 24 ]
then
        ipGrep="${ipArray[0]}.${ipArray[1]}.${ipArray[2]}."
fi

if [ $mask -lt 24 ]
then
        ipGrep="${ipArray[0]}.${ipArray[1]}."
fi

arp-scan $1 | grep -v "Interface" | grep $ipGrep > hosts.txt

nmap -vv -sS -T3 -A -O -sC --script vuln -oX report --stylesheet custom-nmap-template.xsl -iL hosts.txt --exclude-ports 631,515,9100

xsltproc report -o report.html

rm ./report
rm ./hosts.txt
