#!/bin/bash
#
# Creates a Mac OS X framework for GTKMM.
#
# Copyright (C) 2007, 2008 Imendio AB
# Copyright (C) 2009 Rob Caelers
#

source ./framework-helpers.sh

# Do initial setup.
init Gtkmm "2" "$1" "$2" libgtkmm-2.4.1.dylib
copy_main_library

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

# Copy in any libraries we depend on.
resolve_dependencies

# "Relink" library dependencies.
fix_library_references

# Copy and update our "fake" pkgconfig files.
copy_pc_files "atkmm-1.6.pc pangomm-1.4.pc gdkmm-2.4.pc gtkmm-2.4.pc"

# Create the library that will be the main framework library.
build_framework_library

echo "Done."
