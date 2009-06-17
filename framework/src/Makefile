#
# Copyright (C) 2007, 2008 Imendio AB
#

CFLAGS = -Wall -gstabs+3 -flat_namespace -mmacosx-version-min=10.4 -isysroot /Developer/SDKs/MacOSX10.4u.sdk -arch ppc -arch i386 \
-I$(framework)/Headers/ -L$(framework)/Libraries/ -install_name $(framework)/Versions/$(version)/$@

PWD = $(shell pwd)
ROOT = $(shell dirname $(framework)) #hacked by easyb

GTK_LDFLAGS = -F$(ROOT)

all: GLib Cairo Gtk GLibmm Gtkmm

GLib:
	@echo "$(path)$(ROOT)"
	gcc $(CFLAGS) -dynamiclib -o $@ $@.c $(GLIB_NAME) $(GLIB_INCLUDES) $(GLIB_SUBLIBS) $(GLIB_LIBS)

Cairo:
	gcc $(CFLAGS) -dynamiclib -o $@ $@.c $(CAIRO_NAME) $(CAIRO_INCLUDES) $(CAIRO_SUBLIBS) $(CAIRO_LIBS)

Gtk: Gtk.c
	gcc $(CFLAGS) -dynamiclib -o $@ $@.c $(GTK_NAME) $(GTK_INCLUDES) $(GTK_SUBLIBS) $(GTK_LIBS)

	
GLibmm:
	gcc $(CFLAGS) -dynamiclib -o $@ $@.c $(GLIBMM_NAME) $(GLIBMM_INCLUDES) $(GLIBMM_SUBLIBS) $(GLIBMM_LIBS)
	
Gtkmm:
	gcc $(CFLAGS) -dynamiclib -o $@ $@.c $(GTKMM_NAME) $(GTKMM_INCLUDES) $(GTKMM_SUBLIBS) $(GTKMM_LIBS)

GTKMM_LIBS = \
	-lgtkmm-2.4.1 \
	-lgdkmm-2.4.1 \
	-latkmm-1.6.1 \
	-lpangomm-1.4.1
	
GTKMM_SUBLIBS = \
	-sub_library libgtkmm-2 \
	-sub_library libgdkmm-2 \
	-sub_library libatkmm-1 \
	-sub_library libpangomm-1


GLIBMM_LIBS = \
	-lglibmm-2.4.1 \
	-lgiomm-2.4.1 \
	-lsigc-2.0.0 \
	-lglibmm_generate_extra_defs-2.4.1

GLIBMM_SUBLIBS = \
	-sub_library libglibmm-2 \
	-sub_library libgiomm-2 \
	-sub_library libsigc-2 \
	-sub_library libglibmm_generate_extra_defs-2


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

clean:
	rm -rf Gtk GLib Cairo Loudmouth Libglade GLibmm Gtkmm
