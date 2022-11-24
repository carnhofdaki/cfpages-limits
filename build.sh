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

# Following is done always
wget $HOST/files.txt
while read file
do
  echo Downloading $HOST/$file...
  wget -q $HOST/$file
  echo ...done
done < files.txt

# Now check if there is newer version
# on prunednode.today
# If there is no new version, make an
# empty latest.zip file so it is not
# downloaded.
# If there is, rename files.txt to files-old.txt
if
  test "$OVER" = "$VER"
then
  > latest.zip
else
  mv files.txt files-old.txt
  # The latest.zip will be greater than zero
  # and downloaded by init.sh
fi

# Download what is needed
. ./init.sh

# If latest.zip is bigger than zero, split it
# and make a new files.txt
test -s latest.zip && {
  split -a 3 -b 24M --verbose latest.zip latest.zip.${OVER}.
  ls latest.zip.${OVER}.* > files.txt
}
rm -rfv latest.zip

# Change links to the script file
sed -i 's/latest\.zip/latest\.sh\.txt/' index.html
