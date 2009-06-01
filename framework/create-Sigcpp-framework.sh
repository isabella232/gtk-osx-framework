#!/bin/bash
#
# Creates a Mac OS X framework for Sigc++
#
# Copyright (C) 2007, 2008 Imendio AB
# Copyright (C) 2009 Rob Caelers
#

source ./framework-helpers.sh

# Do initial setup.
init Sigcpp "1" "$1" "$2" libsigc-2.0.0.dylib
copy_main_library

# Copy in any libraries we depend on.
resolve_dependencies

# "Relink" library dependencies.
fix_library_references

# Copy header files.
copy_headers \
    include/sigc++-2.0 .  \
    lib/sigc++-2.0/include .
    
# Copy and update our "fake" pkgconfig files.
copy_pc_files "sigc++-2.0.pc"

# Create the library that will be the main framework library.
build_framework_library

echo "Done."
