#!/bin/bash
#
# Creates Mac OS X frameworks for GLib, GTK+, Cairo, etc.
#
# Copyright (C) 2007, 2008 Imendio AB
#

# We apply some jhbuild magic to force the use of framework versions
# over the normally installed versions.
#
# Note that the default is to run "make clean" since otherwise we will
# still might link against the old non-framework installations.
#
# Also note that it is assumed that the cfw-10.4 jhbuild configuration
# has been used to build everything needed before this script is
# started (JHB=cfw-10.4 jhbuild bootstrap; jhbuild build).
#

# Use the right configuration for jhbuild.
export JHB=cfw-10.4u

build_dir=build

all_modules="GLib Cairo Gtk Libglade" #WebKitGtk Loudmouth GLibmm Cairomm Gtkmm Libglademm

PREFIX=`jhbuild getenv JHBUILD_PREFIX`
case "$PREFIX" in
    /*)
        ;;
    *)
        echo "No prefix setup, make sure you have a recent jhbuildrc file from"
        echo " http://developer.imendio.com/projects/gtk-macosx/"
        echo "and a framework creation setup (\".jhbuildrc-$JHB\" file)."
        exit 1
        ;;
esac

print_usage()
{
    echo "Usage: `basename $0` [-fnlhu] [FRAMEWORK...]"
    echo "Options:"
    echo "  -f        - Do not rebuild, just recreate the frameworks"
    echo "  -n        - Do not update modules (network-less mode)"
    echo "  -l        - Do not run 'make clean' before building"
    echo "  -s        - Start a shell for manual building for each framework"
    echo "  -h        - Display this help text"
    echo "  -u        - Don't uninstall" # hacked by easyb...
    echo "            - FRAMEWORK... is an optional list of frameworks to create"
    echo "              Valid framework names are: $all_modules"
}

uninstall_modules()
{
    # Uninstall so the following modules don't link against the
    # dylibs, but the frameworks instead.
    for m in $*; do
        srcdir=`jhbuild gtk-osx-get-srcdir $m`
        if [ "x$srcdir" != x ]; then
            jhbuild run sh -c "cd $srcdir 2>/dev/null && make uninstall"
        fi
    done
}

install_modules()
{
    for m in $*; do
        srcdir=`jhbuild gtk-osx-get-srcdir $m`
        if [ "x$srcdir" != x ]; then
            jhbuild run sh -c "cd $srcdir 2>/dev/null && make install"
        fi
    done
}

create_framework()
{
    framework=$1
    shift 1

    if (echo "$modules" | grep -w $framework) >/dev/null; then
        modules=`echo $modules | sed -e 's/$framework//'`

        if [ "x$shell" == xyes ]; then
            jhbuild shell
            exit 0
        fi

        # Special-case WebKit, "make clean" breaks it...
        clean_save=$clean
        if [ "$*" == "WebKit" ]; then
            clean=
        fi
        
        if [ $rebuild == yes ]; then
            # Uninstall (from any previous attempts that failed) so
            # the following modules don't link against the dylibs, but
            # the frameworks instead.
          #uninstall_modules $*

            rm "$PREFIX"/lib/*.la 2>/dev/null
            jhbuild build $update $clean $* || exit 1         # easyb: switched from buildone to build to use metamodules,
                                                              #        can't use original modulesets anymore though
        #else
        #    if [ $inst == yes ]; then
        #     install_modules $*              # hacked by easyb...
        #    fi
        fi

        clean=$clean_save

        rm -rf $build_dir/$framework.framework
        #rm -rf $framework-runtime.framework

        ./create-$framework-framework.sh $PREFIX $build_dir || exit 1             # hacked by easyb...

        #cp -R $framework.framework $framework-runtime.framework || exit 1
        # FIXME: This only removes the symlinks.
        #rm -rf $framework-runtime.framework/Headers
        #rm -rf $framework-runtime.framework/Resources/dev
        #strip ...

        if [ $rebuild == yes ] && [ $uinst == yes ]; then
            # Uninstall so the following modules don't link against the
            # dylibs, but the frameworks instead.
            uninstall_modules $*
        fi
    fi
}

use_framework()
{
    framework=$1

    if [ "x$JHB_PREPEND_FRAMEWORKS" == x ]; then
        export JHB_PREPEND_FRAMEWORKS=`pwd`/$build_dir/$framework.framework
    else
        export JHB_PREPEND_FRAMEWORKS="$JHB_PREPEND_FRAMEWORKS:`pwd`/$build_dir/$framework.framework"
    fi
}

shell=
rebuild=yes
update=
clean=-c
inst=yes
uinst=yes
while getopts "fnlshua" o; do
    case "$o" in
        f)
            rebuild=no
            ;;
        n)
            update=-n
            ;;
        l)
            clean=
            ;;
        s)
            shell=yes
            ;;
        u)
            uinst=no
            ;;
        h)
            print_usage
            exit 0
            ;;
        ?)
            print_usage
            exit 1
            ;;

    esac
done
shift $(($OPTIND - 1))

modules=$*

if [ "x$modules" != x ]; then
    for m in $modules; do
        found=
        for a in $all_modules; do
            if [ $m == $a ]; then
                found=$m
                break;
            fi
        done
        if [ "x$found" == x ]; then
            echo "Invalid framework: $m"
            exit 1
        fi
    done
else
    modules=$all_modules
fi


  
mkdir -p $build_dir
  

create_framework GLib meta-glib-universal
use_framework GLib

create_framework Cairo cairo
use_framework Cairo

create_framework Gtk meta-gtk-universal
use_framework Gtk

create_framework Libglade libglade
use_framework Libglade

exit 0

#create_framework Loudmouth loudmouth ##FIXME##
#use_framework Loudmouth

#create_framework WebKitGtk WebKit ##FIXME##
#use_framework WebKitGtk

create_framework GLibmm doxygen libsigc++2 glibmm
use_framework GLibmm

create_framework Cairomm cairomm
use_framework Cairomm 

create_framework Gtkmm pangomm gtkmm 
use_framework Gtkmm

create_framework Libglademm libglademm
use_framework Libglademm



