#!/bin/sh

export TZ=UTC
export LC_ALL=C
export LANG=C

df -h
pwd
df -h .
free -h

OHOST=prunednode.today
HOST=cfpages-limits.pages.dev
GREP="grep -o '[0-3][0-9]\.[0-1][0-9]\.[0-9]\+'"
OVER=$(echo eval "wget -O - $OHOST | $GREP")
echo OVER is $OVER
VER=$(echo eval "wget -O - $HOST | $GREP")
echo VER is $VER
if
  "$OVER" != "$VER"
then
  > latest.zip
  wget -O - $HOST/files.txt | while read file
  do
    wget $HOST/$file
    cat $file >> latest.zip
    rm -rf $file
  done
fi

. ./init.sh

split -a 7 -b 24M --verbose latest.zip latest.zip.
rm -v latest.zip
ls latest.zip.* > files.txt
