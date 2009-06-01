#!/bin/bash
#
# Creates a Mac OS X framework for gnet.
#
# Copyright (C) 2007, 2008 Imendio AB
# Copyright (C) 2009 Rob Caelers
#

source ./framework-helpers.sh

# Do initial setup.
init GNet "2" "$1" "$2" libgnet-2.0.0.dylib
copy_single_main_library

# Copy in any libraries we depend on.
resolve_dependencies

# "Relink" library dependencies.
fix_library_references

# Copy header files.
copy_headers \
    include/gnet-2.0 . \
    lib/gnet-2.0/include .
    
# Copy and update our "fake" pkgconfig files.
copy_pc_files "gnet-2.0.pc"

echo "Done."
