#!/bin/bash
#
# Prepares frameworks for system installation and installs them.
#
# Copyright (C) 2007, 2008 Imendio AB
#

source="$1"
target="$2"

for framework in `ls -d $source/*.framework`; do
    basename=`basename "$framework"`

    echo "Installing $basename..."

    mkdir -p $target
    cp -Rp $framework $target
    rm -rf $target/$basename/Resources/dev/
    
    ./relocate-framework.sh $target/$basename $framework @executable_path/../Frameworks/$basename
done