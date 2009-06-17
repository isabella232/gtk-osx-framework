#!/bin/bash
#
# Creates a Mac OS X framework for libcairomm.
#
# Copyright (C) 2007, 2008 Imendio AB
#

source ./framework-helpers.sh

# Do initial setup.
init Gtkmm "2" libgtkmm-2.4.1.dylib "$@"			### hacked by easyb ###
copy_single_main_library

# Copy in any libraries we depend on.
resolve_dependencies

# "Relink" library dependencies.
fix_library_references

# Copy header files.
copy_headers \
    include/pangomm-1.4 pangomm \
    include/pangomm-1.4 pangomm.h \
    include/atkmm-1.6 atkmm \
    include/atkmm-1.6 atkmm.h \
    include/gdkmm-2.4 gdkmm \
    include/gdkmm-2.4 gdkmm.h \
    include/gtkmm-2.4 gtkmm \
    include/gtkmm-2.4 gtkmm.h \
    lib/gtkmm-2.4/include gtkmmconfig.h \
    lib/gdkmm-2.4/include gdkmmconfig.h

# Copy proc
pkg=pangomm-1.4
dest="$framework"/Resources/dev/lib/$pkg
mkdir -p $dest
cp -R "$old_prefix"/lib/$pkg/proc $dest
  
# Copy and update our "fake" pkgconfig files.
copy_pc_files "atkmm-1.6.pc pangomm-1.4.pc gdkmm-2.4.pc gtkmm-2.4.pc"

echo "Done."
