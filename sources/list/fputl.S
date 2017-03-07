/*M
.SH NAME
fputl - file put list (rekursiv) 

.SH SYNOPSIS
.nf
#include<_list.h>

single fputl(L,pf)  
list L; 
FILE *pf;
  
.SH DESCRIPTION
.TP 4
.B pf
points to the file *pf.
.PP
fputl writes the list L to the file *pf and returns 0 by success and ERROR else. 

M*/
      
/*H
	Version 1       23.02.1987     R.Boeffgen
	Version 2       24.03.1987     islist zu !isatom.  RB
	Version 3       01.12.1993     ein voellig unmotiviertes ltop() ersetzt.  MC
   DATE fputl         : 890501.940315
H*/


# include <_list.h>

single fputl( L , pf )
list L;
FILE *pf;
{
	obj M;
   /***    Oeffnende Klammer kontrolliert ausgeben    ***/
	if ( fputc('(',pf) == EOF )  {
		errmsgio( "fputl", "EA104" );
		return( ERROR );
	}
   /***    Objekte der Liste ausgeben    ***/
	while ( L != _0 )  {
		fputc(' ', pf );
		M = lfirst( L );
		if ( !isatom(M) )  fputl( M, pf );
		else  fputa( M, pf );
		fputc(' ', pf );
		L = lred( L );
	}
   /***    Schliessende Klammer kontrolliert ausgeben    ***/
	if ( fputc(')',pf) == EOF )  {
		errmsgio( "fputl", "EA104" );
		return( ERROR );
	}
	return( 0 );
}
