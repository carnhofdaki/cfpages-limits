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

downthem() {
  wget $HOST/$1
  while read file
  do
    echo Downloading $HOST/$file...
    wget -q $HOST/$file
    echo ...done
  done < $1
}

# Following is done always
downthem files.txt
for file in latest.zip.${OVER}.[a-z][a-z][a-z]
do
  ln "$file" "${file}.zip"
done
ls latest.zip.${OVER}.*.zip > files.txt

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
  downthem files-old.txt
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
