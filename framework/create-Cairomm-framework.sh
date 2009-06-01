#!/bin/bash
#
# Creates a Mac OS X framework for Cairomm.
#
# Copyright (C) 2007, 2008, 2009 Imendio AB
# Copyright (C) 2009 Rob Caelers
#

source ./framework-helpers.sh

# Do initial setup.
init Cairomm "1" "$1" "$2" libcairomm-1.0.1.dylib
copy_main_library

# Copy in any libraries we depend on.
resolve_dependencies

# "Relink" library dependencies.
fix_library_references

# Copy header files.
copy_headers \
    include/cairomm-1.0 cairomm

# Copy and update our "fake" pkgconfig files.
copy_pc_files "cairomm-1.0.pc cairomm-ft-1.0.pc cairomm-pdf-1.0.pc cairomm-png-1.0.pc cairomm-ps-1.0.pc cairomm-quartz-1.0.pc cairomm-quartz-font-1.0.pc cairomm-svg-1.0.pc"

# Create the library that will be the main framework library.
build_framework_library

echo "Done."
