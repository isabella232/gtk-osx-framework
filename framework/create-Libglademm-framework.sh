#!/bin/bash
#
# Creates a Mac OS X framework for libglade.
#
# Copyright (C) 2007, 2008 Imendio AB
#

source ./framework-helpers.sh

pkg=libglademm-2.4

# Do initial setup.
init Libglademm "2" $pkg.dylib "$@"			### hacked by easyb ###
copy_single_main_library

# Copy in any libraries we depend on.
resolve_dependencies

# "Relink" library dependencies.
fix_library_references

# Copy header files.
copy_headers \
    include/$pkg libglademm \
    include/$pkg libglademm.h \
    lib/$pkg/include libglademmconfig.h

# Copy and update our "fake" pkgconfig files.
copy_pc_files "$pkg.pc"

# Copy proc
dest="$framework"/Resources/dev/lib/$pkg
mkdir -p $dest
cp -R "$old_prefix"/lib/$pkg/proc $dest

echo "Done."
