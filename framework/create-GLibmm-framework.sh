#!/bin/bash
#
# Creates a Mac OS X framework for libglibmm.
#
# Copyright (C) 2007, 2008 Imendio AB
#

source ./framework-helpers.sh

# Do initial setup.
init GLibmm "2" libglibmm-2.4.1.dylib "$@"			### hacked by easyb ###
copy_main_library

# Copy in libraries manually since nothing links to them so they are
# not pulled in automatically.
cp "$old_prefix"/lib/libgiomm-2.4.1.dylib "$framework"/Libraries/
cp "$old_prefix"/lib/libglibmm_generate_extra_defs-2.4.1.dylib "$framework"/Libraries/

# Copy in any libraries we depend on.
resolve_dependencies

# "Relink" library dependencies.
fix_library_references

# Copy header files.
copy_headers \
    include/glibmm-2.4 glibmm \
    include/glibmm-2.4 glibmm.h \
    include/glibmm-2.4 glibmm_generate_extra_defs \
    include/giomm-2.4 giomm \
    include/giomm-2.4 giomm.h \
    lib/glibmm-2.4/include/ glibmmconfig.h \
    include/sigc++-2.0 sigc++ \
    lib/sigc++-2.0/include/ sigc++config.h
 
# Copy proc
dest="$framework"/Resources/dev/lib/glibmm-2.4
mkdir -p $dest
cp -R "$old_prefix"/lib/glibmm-2.4/proc $dest

escaped_framework=`echo "$framework" | sed -e 's@\/@\\\/@g' -e 's@\.@\\\.@g'`
#### Will break when installed ###
cat "$old_prefix"/lib/glibmm-2.4/proc/gmmproc | sed -e "s/\(my \$prefix = \).*/\1\"$escaped_framework\/Versions\/$version\/Resources\/dev\";/" > $dest/proc/gmmproc

# Copy and update our "fake" pkgconfig files.
copy_pc_files "glibmm-2.4.pc giomm-2.4.pc sigc++-2.0.pc"

copy_aclocal_macros "glibmm_check_perl.m4"

build_framework_library

# Needed by pangomm
ln -s "$framework"/GLibmm "$framework"/Versions/$version/Resources/dev/lib/libglibmm_generate_extra_defs-2.4.dylib || do_exit 1

echo "Done."
