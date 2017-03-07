/*M
.SH NAME
fputlr - file put list of rational numbers

.SH SYNOPSIS
.nf
#include<_arith1.h>

single fputlr(L,pf)
list L;
FILE *pf;

.SH DESCRIPTION
fputlr()  writes the the list L of rational numbers
to the output file *pf and returns 0.
In case of a failure, the return code is ERROR.
M*/
/*H
	Version 1       24.05.1988      Klaus Petry     analog fputli
   DATE fputlr        : 890501
H*/


# include <_arith1.h>

single fputlr ( L , pf )
list L;
FILE *pf;
{
   /***    Oeffnende Klammer kontrolliert ausgeben    ***/
	if ( fputc('(',pf) == EOF )  {
		errmsgio( "fputlr", "EA104" );
		return( ERROR );
	}
   /***    Objekte der Liste ausgeben    ***/
	bind( L );
	while ( L!=_0 )  {
		fputc(' ', pf );
		if (fputr( lfirst(L), pf ) == ERROR ) {
			/* Fehlermeldung schon in fputr */
			return(ERROR);
			}
		fputc(' ', pf );
		L = lred( L );
	}
   /***    Schliessende Klammer kontrolliert ausgeben    ***/
	if ( fputc(')',pf) == EOF )  {
		errmsgio( "fputlr", "EA104" );
		return( ERROR );
	}
	return( 0 );
}
