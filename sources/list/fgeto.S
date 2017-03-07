/*M
.SH NAME
fgeto - file get object

.SH SYNOPSIS
.nf
#include<_list.h>

obj fgeto(pf)  
FILE *pf;
  
.SH DESCRIPTION
.TP 4
.B pf
points to the file *pf.
.PP
fgeto reads an object from the file *pf and returns it. In case of an error, fgeto returns ERROR.

M*/
        
/*H
	Version  1      04.03.1987      R.Boeffgen
   DATE fgeto         : 890501
H*/


# include <_list.h>

obj fgeto( pf )
FILE *pf;
{
	obj a;
	int c = fgetcs( pf );
	ungetc( c,pf );
   /***    Liste    ***/
	if  ( c == '(' )  a = fgetl( pf );
   /***    Objekt    ***/
	else  a = fgeta( pf );
   /***    Fehler    ***/
	if ( a == ERROR )  errmsgio( "fgeto", "EA004" );
   /***    Rueckgabe    ***/
	return( a );
}
