/*
 *      print.c         logo printing module                    dvb
 *
 *	Copyright (C) 1993 by the Regents of the University of California
 *
 *      This program is free software; you can redistribute it and/or modify
 *      it under the terms of the GNU General Public License as published by
 *      the Free Software Foundation; either version 2 of the License, or
 *      (at your option) any later version.
 *  
 *      This program is distributed in the hope that it will be useful,
 *      but WITHOUT ANY WARRANTY; without even the implied warranty of
 *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *      GNU General Public License for more details.
 *  
 *      You should have received a copy of the GNU General Public License
 *      along with this program; if not, write to the Free Software
 *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#include "logo.h"
#include "globals.h"
#include <stdarg.h>

int print_stringlen;
char *print_stringptr;
extern void real_print_help(), real_print_node();
int x_margin=0, y_margin=0;

BOOLEAN print_backslashes = FALSE;

#ifdef mac
BOOLEAN boldmode = 0;
#endif
#ifdef ibm
extern BOOLEAN in_graphics_mode;
#endif

void update_coords(char ch)
{
    int i;

#ifdef ibm
#ifndef __ZTC__
    check_scroll();
#endif
#endif
    if (ch == '\n') {
	x_coord = 0;
	y_coord++;
	for (i = 0; i < x_margin; i++) print_char(stdout,' ');
    } else if (ch == '\b') {
	if (x_coord > 0) --x_coord;
    } else if (ch == '\t') {
	x_coord &= ~07;
	x_coord += 8;
    } else if (ch != '\007')
	x_coord++;
    if (x_coord > x_max) {
	y_coord += x_coord/x_max;
	x_coord %= x_max;
    }
    if (y_coord > y_max) y_coord = y_max;
}

void print_char(FILE *strm, char ch)
{
    if (strm) {
	if (interactive && strm==stdout) {
#ifdef mac
	    if (boldmode) {
		if (ch == '\2')
		    boldmode = 0;
		else
		    ch = setparity(ch);
	    } else if (ch == '\1')
		boldmode = 1;
#endif
#ifdef ibm
	    if (ch == '\1')
		ibm_bold_mode();
	    if (ch == '\2')
		ibm_plain_mode();
#ifdef __ZTC__
	    ztc_put_char(ch);
#else
	    if (in_graphics_mode && ibm_screen_top == 0)
		lsplitscreen();
	    if (ch == '\n' || in_graphics_mode)
		putc(ch, strm);
	    else if (ch != '\1' && ch != '\2')
		putch(ch); /* takes advantage of bold attribute */
#endif
#else
	    putc(ch, strm);
#endif
	} else	    /* printing to stream but not screen */
	    putc(ch, strm);
	if (strm == stdout) {
	    if (dribblestream != NULL)
		putc(ch, dribblestream);
	    update_coords(ch);
	}
    } else {	    /* printing to string */
	if (--print_stringlen > 0)
	    *print_stringptr++ = ch;
    }
}

void print_space(FILE *strm)
{
    print_char(strm,' ');
}

/*VARARGS2*/
void ndprintf(FILE *strm, char *fmt, ...)
{
    va_list ap;
    NODE *nd;
    char *cp;
    char ch;

    va_start(ap,fmt);
    while ((ch = *fmt++) != '\0') {
	if (ch == '%') {
	    ch = *fmt++;
	    if (ch == 's')    /* show */
		print_node(strm,va_arg(ap,NODE *));
	    else if (ch == 'p') { /* print */
		nd = va_arg(ap,NODE *);
		if (is_list(nd))
		    print_help(strm,nd);
		else
		    print_node(strm,nd);
	    } else if (ch == 't') { /* text */
		cp = va_arg(ap,char *);
		while (ch = *cp++) print_char(strm,ch);
	    } else {
		print_char(strm,'%');
		print_char(strm,ch);
	    }
	} else print_char(strm,ch);
    }
    va_end(ap);
}

void real_print_help(FILE *strm, NODE *ndlist, int depth, int width)
{
    NODE *arg = NIL;
    int wid = width;

    while (ndlist != NIL) {
	arg = car(ndlist);
	ndlist = cdr(ndlist);
	if (check_throwing) break;
	real_print_node(strm, arg, depth, width);
	if (ndlist != NIL) {
	    print_space(strm);
	    if (--wid == 0) {
		ndprintf(strm, "...");
		break;
	    }
	}
    }
}

void real_print_node(FILE *strm, NODE *nd, int depth, int width)
{
    int i;
    char *cp;
    NODETYPES ndty;

    if (depth == 0) {
	ndprintf(strm, "...");
	return;
    }
    if (nd == NIL) {
	print_char(strm,'[');
	print_char(strm,']');
    } else if (nd == UNBOUND) {
	ndprintf(strm, "UNBOUND");
    } else if ((ndty = nodetype(nd)) & NT_PRIM) {
	ndprintf(strm, "PRIM");
    } else if (ndty & NT_LIST) {
	print_char(strm,'[');
	real_print_help(strm, nd, depth-1, width);
	print_char(strm,']');
    } else if (ndty == ARRAY) {
	int i = 0, dim = getarrdim(nd), wid;
	NODE **pp = getarrptr(nd);

	if (width < 0) wid = dim;
	else wid = (dim > width ? width : dim);
	print_char(strm,'{');
	while (i < wid) {
	    real_print_node(strm,*pp++,depth-1,width);
	    if (++i < dim) print_space(strm);
	}
	if (wid < dim) ndprintf(strm, "...");
	print_char(strm,'}');
	if (print_backslashes && (getarrorg(nd) != 1)) {
	    char org[] = "@	";

	    sprintf(&org[1],"%d",getarrorg(nd));
	    ndprintf(strm,org);
	}
    } else if (ndty == QUOTE) {
	print_char(strm, '\"');
	print_node(strm, car(nd));
    } else {
	int wid;

	nd = cnv_node_to_strnode(nd);
	cp = getstrptr(nd);
	if (width < 0) wid = getstrlen(nd);
	else {
	    wid = (width < 10 ? 10 : width);
	    wid = (wid < getstrlen(nd) ? wid : getstrlen(nd));
	}

	if (print_backslashes == FALSE)
	    for (i = 0; i < wid; i++) {
		print_char(strm,clearparity(*cp++));
	    }
	else
	    for (i = 0; i < wid; i++) {
		if (getparity(*cp)) {
		    print_char(strm,'\\');
		}
		print_char(strm,clearparity(*cp++));
	    }
	if (wid < getstrlen(nd)) ndprintf(strm, "...");
	gcref(nd);
    }
}

int find_limit(NODE *nd)
{
    int val = -1;

    if (nd == NIL) return(-1);
    nd = cnv_node_to_numnode(valnode__caseobj(nd));
    if (nodetype(nd) == INT) val = getint(nd);
    gcref(nd);
    return(val);
}

void print_help(FILE *strm, NODE *nd)
{
    real_print_help(strm, nd, find_limit(Printdepthlimit),
		    find_limit(Printwidthlimit));
}

void print_node(FILE *strm, NODE *nd)
{
    real_print_node(strm, nd, find_limit(Printdepthlimit),
		    find_limit(Printwidthlimit));
}

void print_nobrak(FILE *strm, NODE *nd)
{
    if (is_list(nd)) print_help(strm, nd);
    else print_node(strm, nd);
}

void new_line(FILE *strm)
{
    print_char(strm,'\n');
}

NODE *lshow(NODE *args)
{
    print_help(writestream, args);
    new_line(writestream);
    return(UNBOUND);
}

void type_help(NODE *args, int sp)
{
    NODE *arg = NIL;

    while (args != NIL) {
	arg = car(args);
	args = cdr(args);
	if (is_list(arg))
	    print_help(writestream, arg);
	else
	    print_node(writestream, arg);
	if (sp && (args != NIL)) {
	    print_space(writestream);
	}
    }
}

NODE *ltype(NODE *args)
{
    type_help(args,0);
    return(UNBOUND);
}

NODE *lprint(NODE *args)
{
    type_help(args,1);
    new_line(writestream);
    return(UNBOUND);
}
