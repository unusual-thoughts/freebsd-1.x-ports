/********************************************************************
 * lindner
 * 3.2
 * 1993/07/23 03:18:50
 * /home/mudhoney/GopherSrc/CVS/gopher+/gopherd/ext.h,v
 * Exp
 *
 * Paul Lindner, University of Minnesota CIS.
 *
 * Copyright 1991, 1992 by the Regents of the University of Minnesota
 * see the file "Copyright" in the distribution for conditions of use.
 *********************************************************************
 * MODULE: ext.h
 * Header file and access methods for filename extension routines
 *********************************************************************
 * Revision History:
 * ext.h,v
 * Revision 3.2  1993/07/23  03:18:50  lindner
 * Mods for using decoder:'s
 *
 * Revision 3.1.1.1  1993/02/11  18:02:51  lindner
 * Gopher+1.2beta release
 *
 * Revision 1.3  1993/02/09  22:13:57  lindner
 * Added Language attributes
 *
 * Revision 1.2  1993/01/30  23:57:44  lindner
 * Changed fcn prefix to EX and EXA
 *
 * Revision 1.1  1992/12/10  23:13:27  lindner
 * gopher 1.1 release
 *
 *
 *********************************************************************/


#ifndef EXT_H
#define EXT_H

#include "DAarray.h"
#include "STRstring.h"
#include "boolean.h"

/*** Map extensions to any of these ***/

#define EXT_ERROR -1
#define EXT_VIEW 1
#define EXT_IGNORE 2
#define EXT_ABSTRACT 3
#define EXT_BLOCK 4
#define EXT_BLOCKREF 5
#define EXT_DECODER 6

/****************************************************
 * A structure for mapping filenames to gopher types, and G+types
 */

struct Ext_struct {
     char   Objtype;
     String *View;
     String *ViewLang;
     String *Prefix;
     String *ext;
     int    exttype;  /** One of the constants defined above **/
     String *GenericData;
};

typedef struct Ext_struct Extobj;

/*** Macros and access methods ***/

#define EXgetObjtype(a)     ((a)->Objtype)
#define EXsetObjtype(a,b)   ((a)->Objtype=(b))

#define EXgetView(a)        STRget((a)->View)
#define EXsetView(a,b)      STRset((a)->View,(b))

#define EXgetVLang(a)       STRget((a)->ViewLang)
#define EXsetVLang(a,b)     STRset((a)->ViewLang,(b))

#define EXgetPrefix(a)      STRget((a)->Prefix)
#define EXsetPrefix(a,b)    STRset((a)->Prefix,(b))

#define EXgetExt(a)         STRget((a)->ext)
#define EXsetExt(a,b)       STRset((a)->ext,(b))

#define EXgetExttype(a)     ((a)->exttype)
#define EXsetExttype(a,b)   ((a)->exttype=(b))

#define EXgetBlockname(a)   STRget((a)->GenericData)
#define EXsetBlockname(a,b) STRset((a)->GenericData,(b))

#define EXgetDecoder(a)     STRget((a)->GenericData)
#define EXsetDecoder(a,b)   STRset((a)->GenericData,(b))

Extobj   *EXnew();
void      EXdestroy();
void      EXcpy();


/*** Definitions for an Array of extension objects ***/

typedef DynArray ExtArray;
#define EXAnew()            (ExtArray *)(DAnew(20,EXnew,NULL,EXdestroy,EXcpy))
#define EXAdestroy(a)       (DAdestroy(a))
#define EXAgetEntry(a,b)    (Extobj *)(DAgetEntry((DynArray*)a,b))
#define EXAadd(a,b)         (DApush(a,b))
#define EXAgetNumEntries(a) (DAgetTop(a))

boolean   EXAprocessLine(/*extarr, inputline*/);
boolean   EXAsearch();
boolean   EXAviewSearch();
char *    EXAfindFile();

#endif /** EXT_H **/

