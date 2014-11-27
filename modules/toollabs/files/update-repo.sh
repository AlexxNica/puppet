#! /bin/bash

#
# This script is managed by puppet
#

cd /data/project/.system/deb
for arch in *; do
  if [ -d $arch ]; then
    dpkg-scanpackages $arch > $arch/Packages~
    mv $arch/Packages~ $arch/Packages
  fi
done

