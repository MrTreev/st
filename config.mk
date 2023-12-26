# dwm version
VERSION    = 0.8.5
BINNAME    = st

# paths
BLD        = bld
SRC        = src
MAN        = man
SYS        = sys
PREFIX     = /usr/local
MANDIR     = share/man
WATCH      = $(SRC)/config.h
DEPS       = $(SRC)/boxdraw.c $(SRC)/x.c $(SRC)/hb.c 

PKG_CONFIG = pkg-config

# ST Flags

INCS += -I/usr/X11R6/include
INCS += $(shell $(PKG_CONFIG) --cflags fontconfig)
INCS += $(shell $(PKG_CONFIG) --cflags freetype2)
INCS += $(shell $(PKG_CONFIG) --cflags harfbuzz)

CFLAGS   += $(INCS)
CFLAGS   += -DVERSION=\"${VERSION}\" 
CFLAGS   += -D_XOPEN_SOURCE=600
CFLAGS   += -std=c99
CFLAGS   += -pedantic
CFLAGS   += -Wall
CFLAGS   += -Wno-deprecated-declarations
CFLAGS   += -O1

LIBS += -lm -lrt -lutil -lc
LIBS += -L/usr/X11R6/lib -lX11 -lX11-xcb -lXft -lXrender -lxcb -lxcb-res
LIBS += $(shell $(PKG_CONFIG) --libs fontconfig)
LIBS += $(shell $(PKG_CONFIG) --libs freetype2)
LIBS += $(shell $(PKG_CONFIG) --libs harfbuzz)
LDFLAGS  += $(LIBS)

# Solaris
#CFLAGS = -fast ${INCS} -DVERSION=\"${VERSION}\"
#LDFLAGS = ${LIBS}

# compiler and linker
CC = cc
