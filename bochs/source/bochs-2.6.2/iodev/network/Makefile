# Copyright (C) 2012  The Bochs Project
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA

# Makefile for the iodev/network component of bochs


.SUFFIXES: .cc

prefix          = /home/xt/xtos/bochs
exec_prefix     = ${prefix}
srcdir          = .

bindir          = ${exec_prefix}/bin
libdir          = ${exec_prefix}/lib
datarootdir     = ${prefix}/share
mandir          = ${datarootdir}/man
man1dir         = $(mandir)/man1
man5dir         = $(mandir)/man5
docdir          = $(datarootdir)/doc/bochs
sharedir        = $(datarootdir)/bochs
top_builddir    = ..
top_srcdir      = ../..

SHELL = /bin/bash

MAKE=make

CXX = g++
CXXFLAGS = $(BX_INCDIRS) -g -O2 -D_FILE_OFFSET_BITS=64 -D_LARGE_FILES  $(X_CFLAGS)

LDFLAGS = 
LIBS =  -lm 
RANLIB = ranlib
PLUGIN_PATH=${exec_prefix}/lib
top_builddir    = ../..
LIBTOOL=$(SHELL) $(top_builddir)/libtool
WIN32_DLL_IMPORT_LIBRARY=../../dllexports.a

NETLOW_OBJS = 

BX_INCDIRS = -I.. -I../.. -I$(srcdir)/.. -I$(srcdir)/../.. -I../../instrument/stubs -I$(srcdir)/../../instrument/stubs
LOCAL_CXXFLAGS = $(MCH_CFLAGS)

OBJS_THAT_CAN_BE_PLUGINS = \
   \
  netmod.o

OBJS_THAT_SUPPORT_OTHER_PLUGINS = \
  $(NETLOW_OBJS)

NONPLUGIN_OBJS = $(OBJS_THAT_CANNOT_BE_PLUGINS) $(OBJS_THAT_CAN_BE_PLUGINS) $(OBJS_THAT_SUPPORT_OTHER_PLUGINS)
PLUGIN_OBJS = 

all: libnetwork.a

plugins: $(PLUGIN_OBJS:%.o=libbx_%.la)

libnetwork.a: $(NONPLUGIN_OBJS)
	rm -f  libnetwork.a
	ar rv $@ $(NONPLUGIN_OBJS)
	ranlib libnetwork.a

# standard compile rule for C++ files
.cc.o:
	$(CXX) -c  $(CXXFLAGS) $(LOCAL_CXXFLAGS) $< -o $@

##### building plugins with libtool
%.lo: %.cc
	$(LIBTOOL) --mode=compile --tag CXX $(CXX) -c $(CXXFLAGS) $(LOCAL_CXXFLAGS) $< -o $@

libbx_%.la: %.lo
	$(LIBTOOL) --mode=link --tag CXX $(CXX) -module $< -o $@ -rpath $(PLUGIN_PATH)

# special link rules for plugins that require more than one object file
libbx_netmod.la: netmod.lo $(NETLOW_OBJS:.o=.lo)
	$(LIBTOOL) --mode=link --tag CXX $(CXX) -module netmod.lo $(NETLOW_OBJS:.o=.lo) -o libbx_netmod.la -rpath $(PLUGIN_PATH)

#### building DLLs for win32  (tested on cygwin only)
bx_%.dll: %.o
	$(CXX) $(CXXFLAGS) -shared -o $@ $< $(WIN32_DLL_IMPORT_LIBRARY)

# special link rules for plugins that require more than one object file
bx_netmod.dll: netmod.o $(NETLOW_OBJS)
	$(CXX) $(CXXFLAGS) -shared -o bx_netmod.dll netmod.o $(NETLOW_OBJS) $(WIN32_DLL_IMPORT_LIBRARY)

##### end DLL section

clean:
	rm -f  -rf .libs *.lo *.o *.la *.a *.dll

dist-clean: clean
	rm -f  Makefile

###########################################
# dependencies generated by
#  gcc -MM -I.. -I../.. -I../../instrument/stubs *.cc | sed -e 's/\.cc/.cc/g'
#  gcc -MM -I.. -I../.. -I../../instrument/stubs *.cc | \
#     sed -e 's/\.cc/.cc/g' -e 's/\.o:/.lo:/g'
#
# This means that every source file is listed twice, once with a .o rule
# and then again with an identical .lo rule.  The .lo rules are used when
# building plugins.
###########################################
e1000.o: e1000.cc ../iodev.h ../../bochs.h ../../config.h ../../osdep.h \
 ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h ../pci.h netmod.h e1000.h
eth_fbsd.o: eth_fbsd.cc ../iodev.h ../../bochs.h ../../config.h \
 ../../osdep.h ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h netmod.h
eth_linux.o: eth_linux.cc ../iodev.h ../../bochs.h ../../config.h \
 ../../osdep.h ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h netmod.h
eth_null.o: eth_null.cc ../iodev.h ../../bochs.h ../../config.h \
 ../../osdep.h ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h netmod.h
eth_slirp.o: eth_slirp.cc ../iodev.h ../../bochs.h ../../config.h \
 ../../osdep.h ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h netmod.h
eth_tap.o: eth_tap.cc ../iodev.h ../../bochs.h ../../config.h \
 ../../osdep.h ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h netmod.h
eth_tuntap.o: eth_tuntap.cc ../iodev.h ../../bochs.h ../../config.h \
 ../../osdep.h ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h netmod.h
eth_vde.o: eth_vde.cc ../iodev.h ../../bochs.h ../../config.h \
 ../../osdep.h ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h netmod.h
eth_vnet.o: eth_vnet.cc ../iodev.h ../../bochs.h ../../config.h \
 ../../osdep.h ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h netmod.h
eth_win32.o: eth_win32.cc ../iodev.h ../../bochs.h ../../config.h \
 ../../osdep.h ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h netmod.h
ne2k.o: ne2k.cc ../iodev.h ../../bochs.h ../../config.h ../../osdep.h \
 ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h ../pci.h ne2k.h netmod.h
netmod.o: netmod.cc ../iodev.h ../../bochs.h ../../config.h ../../osdep.h \
 ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h netmod.h
pcipnic.o: pcipnic.cc ../iodev.h ../../bochs.h ../../config.h \
 ../../osdep.h ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h
e1000.lo: e1000.cc ../iodev.h ../../bochs.h ../../config.h ../../osdep.h \
 ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h ../pci.h netmod.h e1000.h
eth_fbsd.lo: eth_fbsd.cc ../iodev.h ../../bochs.h ../../config.h \
 ../../osdep.h ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h netmod.h
eth_linux.lo: eth_linux.cc ../iodev.h ../../bochs.h ../../config.h \
 ../../osdep.h ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h netmod.h
eth_null.lo: eth_null.cc ../iodev.h ../../bochs.h ../../config.h \
 ../../osdep.h ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h netmod.h
eth_slirp.lo: eth_slirp.cc ../iodev.h ../../bochs.h ../../config.h \
 ../../osdep.h ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h netmod.h
eth_tap.lo: eth_tap.cc ../iodev.h ../../bochs.h ../../config.h \
 ../../osdep.h ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h netmod.h
eth_tuntap.lo: eth_tuntap.cc ../iodev.h ../../bochs.h ../../config.h \
 ../../osdep.h ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h netmod.h
eth_vde.lo: eth_vde.cc ../iodev.h ../../bochs.h ../../config.h \
 ../../osdep.h ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h netmod.h
eth_vnet.lo: eth_vnet.cc ../iodev.h ../../bochs.h ../../config.h \
 ../../osdep.h ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h netmod.h
eth_win32.lo: eth_win32.cc ../iodev.h ../../bochs.h ../../config.h \
 ../../osdep.h ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h netmod.h
ne2k.lo: ne2k.cc ../iodev.h ../../bochs.h ../../config.h ../../osdep.h \
 ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h ../pci.h ne2k.h netmod.h
netmod.lo: netmod.cc ../iodev.h ../../bochs.h ../../config.h ../../osdep.h \
 ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h netmod.h
pcipnic.lo: pcipnic.cc ../iodev.h ../../bochs.h ../../config.h \
 ../../osdep.h ../../bx_debug/debug.h ../../config.h ../../osdep.h \
 ../../gui/siminterface.h ../../cpudb.h ../../gui/paramtree.h \
 ../../memory/memory.h ../../pc_system.h ../../gui/gui.h \
 ../../instrument/stubs/instrument.h ../../plugin.h ../../extplugin.h \
 ../../param_names.h
