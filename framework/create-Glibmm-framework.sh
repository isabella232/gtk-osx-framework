#!/bin/bash
#
# Creates a Mac OS X framework for GLibmm.
#
# Copyright (C) 2007, 2008, 2009 Imendio AB
# Copyright (C) 2009 Rob Caelers
#

source ./framework-helpers.sh

fix_pc_file()
{
    escaped_framework=`echo "$framework" | sed -e 's@\/@\\\/@g' -e 's@\.@\\\.@g'`

    cat "$framework"/Versions/$version/Resources/dev/lib/pkgconfig/glibmm-2.4.pc | sed \
        -e "s/\(^gmmprocdir=\).*/\1$escaped_framework\/Versions\/$version\/Resources\/dev\/lib\/proc/" \
        > "$framework"/Versions/$version/Resources/dev/lib/pkgconfig/glibmm-2.4.pc.new || do_exit 1
     mv "$framework"/Versions/$version/Resources/dev/lib/pkgconfig/glibmm-2.4.pc.new \
        "$framework"/Versions/$version/Resources/dev/lib/pkgconfig/glibmm-2.4.pc
}

fix_gmmproc()
{
    escaped_framework=`echo "$framework" | sed -e 's@\/@\\\/@g' -e 's@\.@\\\.@g'`

    cat "$framework"/Versions/$version/Resources/dev/lib/glibmm-2.4/proc/gmmproc | sed \
        -e "s/\/Users\/robc\/Source\/gtkfw\/inst/$escaped_framework\/Versions\/$version\/Resources\/dev/" \
        > "$framework"/Versions/$version/Resources/dev/lib/glibmm-2.4/proc/gmmproc.new || do_exit 1

    mv "$framework"/Versions/$version/Resources/dev/lib/glibmm-2.4/proc/gmmproc.new \
        "$framework"/Versions/$version/Resources/dev/lib/glibmm-2.4/proc/gmmproc

    chmod +x "$framework"/Versions/$version/Resources/dev/lib/glibmm-2.4/proc/gmmproc
}


# Do initial setup.
init GLibmm "2" "$1" "$2" libglibmm-2.4.1.dylib
copy_main_library

# Copy in libraries manually since nothing links to them so they are
# not pulled in automatically.
cp "$old_prefix"/lib/libgiomm-2.4.1.dylib "$framework"/Libraries/
cp "$old_prefix"/lib/libglibmm_generate_extra_defs-2.4.1.dylib "$framework"/Libraries/

mkdir -p "$framework"/Resources/dev/lib 
cp "$old_prefix"/lib/libglibmm_generate_extra_defs-2.4.1.dylib "$framework"/Versions/$version/Resources/dev/lib/
ln -s libglibmm_generate_extra_defs-2.4.1.dylib "$framework"/Versions/$version/Resources/dev/lib/libglibmm_generate_extra_defs-2.4.dylib || do_exit 1

# Copy in any libraries we depend on.
resolve_dependencies

# "Relink" library dependencies.
fix_library_references

# Copy header files.
copy_headers \
    include/giomm-2.4 giomm \
    include/giomm-2.4 giomm.h \
    include/glibmm-2.4 glibmm \
    include/glibmm-2.4 glibmm_generate_extra_defs \
    include/glibmm-2.4 glibmm.h \
    lib/glibmm-2.4/include glibmmconfig.h \
    lib/giomm-2.4/include giommconfig.h

# Copy gmmproc    
mkdir -p "$framework"/Resources/dev/lib/glibmm-2.4/proc
cp -R "$old_prefix"/lib/glibmm-2.4/proc "$framework"/Versions/$version/Resources/dev/lib/glibmm-2.4

# Copy and update our "fake" pkgconfig files.
copy_pc_files "giomm-2.4.pc glibmm-2.4.pc"
fix_pc_file

fix_gmmproc

# Create the library that will be the main framework library.
build_framework_library

copy_aclocal_macros glibmm_check_perl.m4

echo "Done."
