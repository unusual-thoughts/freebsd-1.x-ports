/* Copyright (C) 1989, 1992 Aladdin Enterprises.  All rights reserved.

This file is part of Ghostscript.

Ghostscript is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY.  No author or distributor accepts responsibility
to anyone for the consequences of using it or for whether it serves any
particular purpose or works at all, unless he says so in writing.  Refer
to the Ghostscript General Public License for full details.

Everyone is granted permission to copy, modify and redistribute
Ghostscript, but only under the conditions described in the Ghostscript
General Public License.  A copy of this license is supposed to have been
given to you along with Ghostscript so you can know your rights and
responsibilities.  It should be in a file named COPYING.  Among other
things, the copyright notice and this notice must be preserved on all
copies.  */

/* gsstate.h */
/* Graphics state routines for Ghostscript library */

/* Opaque type for a graphics state */
/*typedef struct gs_state_s gs_state;*/	/* defined in gs.h */

/* Line cap values */
typedef enum {
	gs_cap_butt = 0,
	gs_cap_round = 1,
	gs_cap_square = 2
} gs_line_cap;

/* Line join values */
typedef enum {
	gs_join_miter = 0,
	gs_join_round = 1,
	gs_join_bevel = 2
} gs_line_join;

/* Allocation, freeing, initialization, and copying */
gs_state *gs_state_alloc(P1(const gs_memory_procs *)); /* 0 if fails */
int	gs_state_free(P1(gs_state *));
int	gs_gsave(P1(gs_state *)),
	gs_grestore(P1(gs_state *)),
	gs_grestoreall(P1(gs_state *));
gs_state *gs_gstate(P1(gs_state *));
int	gs_copygstate(P2(gs_state * /*to*/, const gs_state * /*from*/)),
	gs_currentgstate(P2(gs_state * /*to*/, const gs_state * /*from*/)),
	gs_setgstate(P2(gs_state * /*to*/, const gs_state * /*from*/));
gs_state *gs_state_swap_saved(P2(gs_state *, gs_state *));	/* special for save/restore */
int	gs_initgraphics(P1(gs_state *));

/* Device control */
#ifndef gx_device_DEFINED
#  define gx_device_DEFINED
typedef struct gx_device_s gx_device;
#endif
#ifndef gs_prop_item_DEFINED
#  define gs_prop_item_DEFINED
typedef struct gs_prop_item_s gs_prop_item;
extern const uint gs_prop_item_sizeof;
#endif
int	gs_flushpage(P1(gs_state *));
int	gs_copypage(P1(gs_state *));
int	gs_output_page(P3(gs_state *, int, int));
int	gs_copyscanlines(P6(gx_device *, int, byte *, uint, int *, uint *));
gx_device *	gs_getdevice(P1(int));
int	gs_copydevice(P3(gx_device **, const gx_device *, const gs_memory_procs *));
int	gs_makeimagedevice(P7(gx_device **, const gs_matrix *, uint, uint, const byte *, int, const gs_memory_procs *));
void	gs_nulldevice(P1(gs_state *));
int	gs_setdevice(P2(gs_state *, gx_device *));
gx_device *	gs_currentdevice(P1(const gs_state *));
const char *	gs_devicename(P1(const gx_device *));
void	gs_deviceinitialmatrix(P2(gx_device *, gs_matrix *));
int	gs_getdeviceprops_size(P1(gx_device *));
int	gs_getdeviceprops(P2(gx_device *, gs_prop_item *));
int	gs_putdeviceprops(P3(gx_device *, gs_prop_item *, int));
int	gs_closedevice(P1(gx_device *));

/* Line parameters and quality */
int	gs_setlinewidth(P2(gs_state *, floatp));
float	gs_currentlinewidth(P1(const gs_state *));
int	gs_setlinecap(P2(gs_state *, gs_line_cap));
gs_line_cap	gs_currentlinecap(P1(const gs_state *));
int	gs_setlinejoin(P2(gs_state *, gs_line_join));
gs_line_join	gs_currentlinejoin(P1(const gs_state *));
int	gs_setmiterlimit(P2(gs_state *, floatp));
float	gs_currentmiterlimit(P1(const gs_state *));
int	gs_setdash(P4(gs_state *, const float *, uint, floatp));
uint	gs_currentdash_length(P1(const gs_state *));
int	gs_currentdash_pattern(P2(const gs_state *, float *));
float	gs_currentdash_offset(P1(const gs_state *));
int	gs_setflat(P2(gs_state *, floatp));
float	gs_currentflat(P1(const gs_state *));
int	gs_setstrokeadjust(P2(gs_state *, int));
int	gs_currentstrokeadjust(P1(const gs_state *));

/* Color and gray */
#include "gscolor.h"

/* Halftone screen */
int	gs_setscreen(P4(gs_state *, floatp, floatp, float (*)(P2(floatp, floatp))));
int	gs_currentscreen(P4(gs_state *, float *, float *, float (**)(P2(floatp, floatp))));
int	gs_sethalftonephase(P3(gs_state *, int, int));
int	gs_currenthalftonephase(P2(gs_state *, gs_int_point *));
/* Enumeration-style screen definition */
typedef struct gs_screen_enum_s gs_screen_enum;
extern const uint gs_screen_enum_sizeof;
int	gs_screen_init(P4(gs_screen_enum *, gs_state *, floatp, floatp));
int	gs_screen_currentpoint(P2(gs_screen_enum *, gs_point *));
int	gs_screen_next(P2(gs_screen_enum *, floatp));

/* "Client data" interface for graphics states. */
typedef char/*void*/ *(*gs_state_alloc_proc_t)(P1(const gs_memory_procs *mp));
typedef int (*gs_state_copy_proc_t)(P2(char/*void*/ *to, const char/*void*/ *from));
typedef void (*gs_state_free_proc_t)(P2(char/*void*/ *old, const gs_memory_procs *mp));
typedef struct gs_state_client_procs_s {
	gs_state_alloc_proc_t alloc;
	gs_state_copy_proc_t copy;
	gs_state_free_proc_t free;
} gs_state_client_procs;
void	gs_state_set_client(P3(gs_state *, char/*void*/ *, const gs_state_client_procs *));
char/*void*/ *gs_state_client_data(P1(gs_state *));
