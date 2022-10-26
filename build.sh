#!/bin/sh

export TZ=UTC
export LC_ALL=C
export LANG=C

df -h
pwd
df -h .
free -h

OHOST=https://prunednode.today
HOST=https://cfpages-limits.pages.dev
GREP="grep -o '[0-3][0-9]\.[0-1][0-9]\.[0-9]\+'"
OVER=$(eval "wget -O - $OHOST | $GREP")
echo OVER is $OVER
VER=$(eval "wget -O - $HOST | $GREP")
echo VER is $VER
if
  test "$OVER" = "$VER"
then
  > latest.zip
  wget -O - $HOST/files.txt | while read file
  do
    echo Downloading $HOST/$file...
    wget -q $HOST/$file
    cat $file >> latest.zip
    rm -rf $file
    echo ...done
  done
fi

. ./init.sh

# Change links to the script file
sed -i 's/latest\.zip/latest\.sh\.txt/'

split -a 7 -b 24M --verbose latest.zip latest.zip.$VER.
rm -rfv latest.zip
ls latest.zip.* > files.txt
