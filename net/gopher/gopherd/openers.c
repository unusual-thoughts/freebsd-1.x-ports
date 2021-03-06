/********************************************************************
 * lindner
 * 3.4
 * 1993/07/27 05:27:54
 * /home/mudhoney/GopherSrc/CVS/gopher+/gopherd/openers.c,v
 * Exp
 *
 * Paul Lindner, University of Minnesota CIS.
 *
 * Copyright 1991, 1992 by the Regents of the University of Minnesota
 * see the file "Copyright" in the distribution for conditions of use.
 *********************************************************************
 * MODULE: openers.c
 * See below
 *********************************************************************
 * Revision History:
 * openers.c,v
 * Revision 3.4  1993/07/27  05:27:54  lindner
 * Mondo Debug overhaul from Mitra
 *
 * Revision 3.3  1993/04/09  16:23:12  lindner
 * Additional debug stuff
 *
 * Revision 3.2  1993/02/19  21:22:05  lindner
 * Fixed problems with non-chroot() use
 *
 * Revision 3.1.1.1  1993/02/11  18:02:52  lindner
 * Gopher+1.2beta release
 *
 * Revision 1.2  1993/01/30  23:57:44  lindner
 * Fixes so that opening a file doesn't depend on what the current
 * directory is.
 *
 * Revision 1.1  1992/12/10  23:13:27  lindner
 * gopher 1.1 release
 *
 *
 *********************************************************************/



/*
 * Routines that implement safe "openers" so that we can do without
 * the chroot().  This is an advantage because then you can have
 * symbolic links from your gopher server directory to other files
 * that are elsewhere on your system, without (if we've done this right)
 * compromising your security, or allowing access to any files that
 * you don't want made available.
 *
 * The "r" in the names is meant to indicate "restricted".
 * The "u" in the names is meant to indicate "unrestricted".
 */

#include "gopherd.h"
#include "Debug.h"
#include <sys/param.h>	/* for MAXPATHLEN */

/* and restore our real names */
#undef open
#undef fopen
#undef stat
#undef opendir
#undef chdir


char	*fixfile();

int
ropen( path, flags, mode )
char *path;
int flags, mode;
{
     char *p;
     p = fixfile(path);
     if (p != NULL)
	  return( open( p, flags, mode ) );
     return(-1);	/* failed */
}


FILE *
rfopen( filename, type )
char *filename, *type;
{
     char *p;
     p = fixfile(filename);
     if (p != NULL)
	  return( fopen( p, type ) );
     return(NULL);	/* failed */
}


int
rstat( path, buf )
char *path;
struct stat *buf;
{
     char *p;
     p = fixfile(path);
     if (p != NULL)
	  return( stat( p, buf ) );
     return(-1);	/* failed */
}


DIR *
ropendir( dirname )
char *dirname;
{
     char *p;
     p = fixfile(dirname);
     if (p != NULL)
	  return( opendir( p ) );
     return(NULL);	/* failed */
}


/*
 * Restricted chdir.
 * 
 * Change to Data_Dir first if it's an absolute path, 
 * then do a relative chdir from there....
 */

int
rchdir( path )
char *path;
{
     char *p;
     p = fixfile(path);

     Debug("Changing to directory %s\n", p);
     return( chdir( p ) );
}


int
uopen( path, flags, mode )
char *path;
int flags, mode;
{
     return( open( path, flags, mode ) );
}


FILE *
ufopen( filename, type )
char *filename, *type;
{
     return( fopen( filename, type ) );
}


int
ustat( path, buf )
char *path;
struct stat *buf;
{
     return( stat( path, buf ) );
}


DIR *
uopendir( dirname )
char *dirname;
{
     return( opendir( dirname ) );
}


int
uchdir( path )
char *path;
{
     Debug("Changing to directory %s\n", path);
     return( chdir( path ) );
}


/* Make sure the pathname they gave us is safe and secure for use */

char *
fixfile(name)
char *name;
{
     static char newpathbuf[MAXPATHLEN];
     char *newpath;

     newpath = &newpathbuf[0];

     if (!dochroot) {
	  strcpy(newpath, Data_Dir);

	  newpath += strlen(Data_Dir);
     }
     else {
	  strcpy(newpath, "/");
     }
     /* set errno to EPERM in case we reject the request */
     errno = EPERM;

     /*
     ** rip any .. or . entries out, so they can't sneak up out of
     ** the gopher directory.  Need to use dedot2() so we don't clobber
     ** the string they sent us originally.
     */
     dedot2(name,newpath);
     if (*newpath == '/')
	  return(newpathbuf);
     else 
	  return(newpath);
}
