/*  $Revision: 1.1 $
**
**  DBZ compatibility routines, for use if DBZ isn't patched
*/


/* LINTLIBRARY */
int
dbzwritethrough(value)
    int		value;
{
    return value;
}


long
dbztagmask(size)
    long	size;
{
    return size;
}
