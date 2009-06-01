#
# Copyright (C) 2007, 2008 Imendio AB
#

CFLAGS = -Wall -gstabs+3 -flat_namespace -mmacosx-version-min=10.4 -isysroot /Developer/SDKs/MacOSX10.4u.sdk

PWD = $(shell pwd)

GLIB_INCLUDES = -I$(ROOT)/GLib.framework/Headers/ -L$(ROOT)/GLib.framework/Libraries/
GLIB_NAME = -install_name $(ROOT)/GLib.framework/Versions/$(version)/GLib

CAIRO_INCLUDES = -I$(ROOT)/Cairo.framework/Headers/ -L$(ROOT)/Cairo.framework/Libraries/
CAIRO_NAME = -install_name $(ROOT)/Cairo.framework/Versions/$(version)/Cairo

GTK_INCLUDES = -I$(ROOT)/Gtk.framework/Headers/ -L$(ROOT)/Gtk.framework/Libraries/
GTK_LDFLAGS = -F$(ROOT)
GTK_NAME = -install_name $(ROOT)/Gtk.framework/Versions/$(version)/Gtk

SIGCPP_INCLUDES = -I$(ROOT)/Sigcpp.framework/Headers/ -L$(ROOT)/Sigcpp.framework/Libraries/
SIGCPP_LDFLAGS = -F$(ROOT)
SIGCPP_NAME = -install_name $(ROOT)/Sigcpp.framework/Versions/$(version)/Sigcpp

CAIROMM_INCLUDES = -I$(ROOT)/Cairomm.framework/Headers/ -L$(ROOT)/Cairomm.framework/Libraries/
CAIROMM_LDFLAGS = -F$(ROOT)
CAIROMM_NAME = -install_name $(ROOT)/Cairomm.framework/Versions/$(version)/Cairomm

GLIBMM_INCLUDES = -I$(ROOT)/GLibmm.framework/Headers/ -L$(ROOT)/GLibmm.framework/Libraries/
GLIBMM_LDFLAGS = -F$(ROOT)
GLIBMM_NAME = -install_name $(ROOT)/GLibmm.framework/Versions/$(version)/GLibmm

GTKMM_INCLUDES = -I$(ROOT)/Gtkmm.framework/Headers/ -L$(ROOT)/Gtkmm.framework/Libraries/
GTKMM_LDFLAGS = -F$(ROOT)
GTKMM_NAME = -install_name $(ROOT)/Gtkmm.framework/Versions/$(version)/Gtkmm

all: GLib Cairo Gtk Sigcpp Cairomm GLibmm Gtkmm

GLib:
	gcc $(CFLAGS) -dynamiclib -o $@ $@.c $(GLIB_NAME) $(GLIB_INCLUDES) $(GLIB_SUBLIBS) $(GLIB_LIBS)

Cairo:
	gcc $(CFLAGS) -dynamiclib -o $@ $@.c $(CAIRO_NAME) $(CAIRO_INCLUDES) $(CAIRO_SUBLIBS) $(CAIRO_LIBS)

Gtk: Gtk.c
	gcc $(CFLAGS) -dynamiclib -o $@ $@.c $(GTK_NAME) $(GTK_INCLUDES) $(GTK_SUBLIBS) $(GTK_LIBS)

Sigcpp:
	gcc $(CFLAGS) -dynamiclib -o $@ $@.c $(SIGCPP_NAME) $(SIGCPP_INCLUDES) $(SIGCPP_SUBLIBS) $(SIGCPP_LIBS)

Cairomm:
	gcc $(CFLAGS) -dynamiclib -o $@ $@.c $(CAIROMM_NAME) $(CAIROMM_INCLUDES) $(CAIROMM_SUBLIBS) $(CAIROMM_LIBS)

GLibmm:
	gcc $(CFLAGS) -dynamiclib -o $@ $@.c $(GLIBMM_NAME) $(GLIBMM_INCLUDES) $(GLIBMM_SUBLIBS) $(GLIBMM_LIBS)

Gtkmm: 
	gcc $(CFLAGS) -dynamiclib -o $@ $@.c $(GTKMM_NAME) $(GTKMM_INCLUDES) $(GTKMM_SUBLIBS) $(GTKMM_LIBS)

GLIB_LIBS = \
	-lintl.8			\
	-lglib-2.0.0			\
	-lgio-2.0.0			\
	-lgobject-2.0.0			\
	-lgmodule-2.0.0			\
	-lgthread-2.0.0

GLIB_SUBLIBS = \
	-sub_library libintl		\
	-sub_library libglib-2		\
	-sub_library libgio-2		\
	-sub_library libgobject-2	\
	-sub_library libgmodule-2	\
	-sub_library libgthread-2

CAIRO_LIBS = \
	-lz				\
	-lpng12.0			\
	-lpixman-1.0			\
	-lcairo.2

CAIRO_SUBLIBS = \
	-sub_library libcairo		\
	-sub_library libpixman-1

GTK_LIBS = \
	$(GTK_LDFLAGS)			\
	-lpng12.0			\
	-lpango-1.0.0			\
	-lpangocairo-1.0.0		\
	-latk-1.0.0			\
	-lgdk-pixbuf-2.0.0		\
	-lgdk-quartz-2.0.0		\
	-lgtk-quartz-2.0.0		\
	-ligemacintegration.0		\
	-framework Carbon		\
	-framework GLib			\
	-framework Cairo

GTK_SUBLIBS = \
	-sub_library libpango-1		\
	-sub_library libpangocairo-1	\
	-sub_library libatk-1		\
	-sub_library libgdk-pixbuf-2	\
	-sub_library libgdk-quartz-2	\
	-sub_library libgtk-quartz-2	\
	-sub_library libigemacintegration

SIGCPP_LIBS = \
	-lsigc-2.0.0

SIGCPP_SUBLIBS = \
	-sub_library libsigc-2		\

GLIBMM_LIBS = \
	$(GLIBMM_LDFLAGS)		\
	-lglibmm-2.4.1			\
	-lgiomm-2.4.1			\
	-framework GLib			\
	-framework Sigcpp

GLIBMM_SUBLIBS = \
	-sub_library libglibmm-2	\
	-sub_library libgiomm-2

CAIROMM_LIBS = \
	$(CAIROMM_LDFLAGS)		\
	-lcairomm-1.0.1			\
	-framework GLibmm		\
	-framework Cairo

CAIROMM_SUBLIBS = \
	-sub_library libcairomm


GTKMM_LIBS = \
	$(GTKMM_LDFLAGS)		\
	-lpangomm-1.4.1			\
	-latkmm-1.6.1			\
	-lgdkmm-2.4.1			\
	-lgtkmm-2.4.1			\
	-framework GLibmm		\
	-framework Gtk			\

GTKMM_SUBLIBS = \
	-sub_library libpangomm-1	\
	-sub_library libatkmm-1		\
	-sub_library libgdkmm-2		\
	-sub_library libgtkmm-2

clean:
	rm -rf Gtk GLib Cairo Loudmouth Libglade Sigcpp GLibmm Gtkmm
