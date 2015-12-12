#!/bin/sh

filelist=`grep file_filter setup/combolayer-quark.conf | cut -d'=' -f2`
echo Removing ... : $filelist
rm -rf $filelist

# if you want to wipe out .git by default uncomment the following line
# rm -rf .git
