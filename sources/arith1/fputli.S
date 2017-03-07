/*M
.SH NAME
fputli - file put list of integers

.SH SYNOPSIS
.nf
#include<_arith1.h>

single fputli(L,pf)
list L;
FILE *pf;

.SH DESCRIPTION
fputli() writes the integer list L
to the output file *pf and returns 0.
In case of a failure, the return code is ERROR.
M*/
/*H
	Version 1       23.02.1987      R.Boeffgen
   DATE fputli        : 890501
H*/


# include <_arith1.h>

single fputli ( L , pf )
list L;
FILE *pf;
{
   /***    Oeffnende Klammer kontrolliert ausgeben    ***/
	if ( fputc('(',pf) == EOF )  {
		errmsgio( "fputli", "EA104" );
		return( ERROR );
	}
   /***    Objekte der Liste ausgeben    ***/
	bind( L );
	while ( L!=_0 )  {
		fputc(' ', pf );
		fputi( lfirst(L), pf );
		fputc(' ', pf );
		L = lred( L );
	}
   /***    Schliessende Klammer kontrolliert ausgeben    ***/
	if ( fputc(')',pf) == EOF )  {
		errmsgio( "fputli", "EA104" );
		return( ERROR );
	}
	return( 0 );
}
