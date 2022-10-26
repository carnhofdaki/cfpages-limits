#!/bin/sh

df -h
pwd
df -h .
free -h

. ./init.sh

split -a 7 -b 24M latest.zip
rm -v latest.zip
ls latest.zip.* > files.txt
