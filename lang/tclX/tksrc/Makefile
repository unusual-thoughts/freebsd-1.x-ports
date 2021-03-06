# Generated automatically from Makefile.in by configure.
#
# tksrc/Makefile.in --
#
# Makefile to build a wish with Extended Tcl (wishx).
# 
#------------------------------------------------------------------------------
# Copyright 1992-1993 Karl Lehenbauer and Mark Diekhans.
#
# Permission to use, copy, modify, and distribute this software and its
# documentation for any purpose and without fee is hereby granted, provided
# that the above copyright notice appear in all copies.  Karl Lehenbauer and
# Mark Diekhans make no representations about the suitability of this
# software for any purpose.  It is provided "as is" without express or
# implied warranty.
#------------------------------------------------------------------------------
# $Id: Makefile,v 1.2 1994/07/05 14:13:45 ache Exp $
#------------------------------------------------------------------------------
#
SHELL = /bin/sh

#------------------------------------------------------------------------------
# Autoconfig defines that can be overridden in Config.mk

CC          = cc
RANLIB      = ranlib
MCS         = touch
srcdir      = .
srcbasedir  = /usr/ports/lang/tclX
bldbasedir  = /usr/ports/lang/tclX
VPATH       = .
prefix      = /usr/local
exec_prefix = /usr/local
ARCH        = 
XINCLUDES   = # no special path needed
LIBS        = 
XLIBSW      = -lX11

#------------------------------------------------------------------------------
# Include user-editable defines.

.include "${bldbasedir}/Config.mk"

#------------------------------------------------------------------------------

LIBTK.A      = ${bldbasedir}/tkmaster/lib${ARCH}/libtk.a
LIBTKX.A     = ${bldbasedir}/tkmaster/lib${ARCH}/libtkx.a
WISHX        = ${bldbasedir}/tkmaster/bin${ARCH}/wishx
APPINIT      = ${bldbasedir}/tkmaster/src/tkXAppInit.c
SYSLIBS      = ${bldbasedir}/tkmaster/src/SYSLIBS${ARCH}
TKXMAINPP.O  = ${bldbasedir}/tkmaster/lib${ARCH}/tkXmain++.o

LIBTCL.A  = ${bldbasedir}/tclmaster/lib${ARCH}/libtcl.a
LIBTCLX.A = ${bldbasedir}/tclmaster/lib${ARCH}/libtclx.a

# The ordering of the libraries is important.  Some X libs on SysV include
# "random" in a BSD module.  This would conflict with the one in the Tcl
# library if it was brought in.

LDLIBS = ${LIBTKX.A} ${LIBTK.A} ${XLIBSW} ${LIBTCLX.A} ${LIBTCL.A} -lm ${LIBS}

CC_FLAGS = ${CPPFLAGS} ${XCFLAGS} ${CFLAGS} \
           -I${srcbasedir}/src -I${bldbasedir}/src -I${srcbasedir}/tksrc \
           -I${TK_UCB_SRC} -I${TCL_UCB_SRC} ${XINCLUDES}
 
.c.o:
	${CC} ${CC_FLAGS} -c $<

#------------------------------------------------------------------------------

OBJS=tkXinit.o   tkXmain.o  tkXshell.o

UCBOBJS=tkWindow.o

#------------------------------------------------------------------------------
# Compile the TkX library and link wishx.  If the link fails, purge
# the executable, as some systems leave invalid executables around.

all: made.tmp ${WISHX} ${APPINIT} ${SYSLIBS} ${TCL_PLUS_BUILD}

${WISHX}: tkXAppInit.o ${LIBTKX.A} ${LIBTK.A} ${LIBTCLX.A} ${LIBTCL.A} made.tmp
	${CC} ${CC_FLAGS} ${XLDFLAGS} tkXAppInit.o ${LDLIBS} ${XLDLIBS} \
	    -o ${WISHX} || (rm -f ${WISHX}; exit 1)
	if ${DO_STRIPPING} ; then \
	    strip ${WISHX}  ;\
	    ${MCS} ${WISHX} ;\
	else \
	    exit 0 ;\
	fi

made.tmp ${LIBTKX.A}: ${OBJS} ${UCBOBJS}
	${AR} cr ${LIBTKX.A} ${OBJS} ${UCBOBJS}
	${RANLIB} ${LIBTKX.A}
	touch made.tmp

tkWindow.o: tkWindow.c
	MASTER=${TK_MASTERDIR}/`../tools/tkxversion` ;\
	${CC} -c -I${TK_UCB_SRC} ${CC_FLAGS} ${DEFS} \
	    -DTK_LIBRARY=\"$$MASTER\" tkWindow.c

tkWindow.c: ${TK_UCB_SRC}/tkWindow.c
	rm -f tkWindow.c
	echo '#include "tclXconfig.h"' >tkWindow.c
	cat ${TK_UCB_SRC}/tkWindow.c  >>tkWindow.c

tkXinit.o: tkXinit.c
	MASTER=${TK_MASTERDIR}/`../tools/tkxversion` ;\
	${CC} -c ${CC_FLAGS} -DTK_MASTERDIR=\"$$MASTERDIR\" \
            ${srcdir}/tkXinit.c

${APPINIT}: tkXAppInit.c
	rm -f ${APPINIT}
	cp ${srcdir}/tkXAppInit.c ${APPINIT}

${SYSLIBS}: SYSLIBS
	rm -f ${SYSLIBS}
	cp SYSLIBS ${SYSLIBS}

#------------------------------------------------------------------------------
# Make sure tkXmain.c compiles and links with C++.

TCL_PLUS: wishx++ ${TKXMAINPP.O}

wishx++: tkXmain++.o made.tmp
	${CC} ${CC_FLAGS} ${XLDFLAGS} tkXAppInit.o ${LDLIBS} ${XLDLIBS} \
	    -o wishx++ || (rm -f wishx++; exit 1)

tkXmain++.o: tkXmain++.C
	${CCPLUS} -c -I${CPLUSINCL} ${CC_FLAGS} tkXmain++.C

tkXmain++.C: tkXmain.c
	rm -f tkXmain++.C
	cp ${srcdir}/tkXmain.c tkXmain++.C

${TKXMAINPP.O}: tkXmain++.o
	rm -f ${TKXMAINPP.O}
	cp tkXmain++.o ${TKXMAINPP.O}

#------------------------------------------------------------------------------
clean:
	-rm -f made.tmp tkXmain++.C tkXAppInit.o tkWindow.c
	-rm -f ${OBJS} ${UCBOBJS} tkXmain++.o ${WISHX} wishx++

#------------------------------------------------------------------------------
# Restore to the distributed state.

distclean: clean
	rm -f Makefile SYSLIBS
