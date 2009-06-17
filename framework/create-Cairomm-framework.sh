#!/bin/bash
#
# Creates a Mac OS X framework for libcairomm.
#
# Copyright (C) 2007, 2008 Imendio AB
#

source ./framework-helpers.sh

# Do initial setup.
init Cairomm "1" libcairomm-1.0.1.dylib "$@"			### hacked by easyb ###
copy_single_main_library

# Copy in any libraries we depend on.
resolve_dependencies

# "Relink" library dependencies.
fix_library_references

# Copy header files.
copy_headers \
    include/cairomm-1.0 cairomm
    
# Copy and update our "fake" pkgconfig files.
copy_pc_files "cairomm-1.0.pc cairomm-png-1.0.pc cairomm-quartz-1.0.pc cairomm-svg-1.0.pc cairomm-pdf-1.0.pc cairomm-ps-1.0.pc cairomm-quartz-font-1.0.pc"

echo "Done."
