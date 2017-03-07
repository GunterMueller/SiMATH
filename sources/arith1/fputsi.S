/*M
.SH NAME
fputsi - file put single precision

.SH SYNOPSIS
.nf
#include<_arith1.h>

single fputsi(n,pf)
single n;
FILE *pf;

.SH DESCRIPTION
fputsi()
writes the single n
to the output file *pf and returns 0.
In case of a failure, the return code is ERROR.
M*/
/*H
	Version 1       16.03.1987      R.Boeffgen
	Version 2       07.09.1987      Typ-Test entfernt.  RB
   DATE fputsi        : 890501
H*/


# include <_arith1.h>

single fputsi ( n , pf )
single n;
FILE *pf;
{
	static char xstr[14];
   /***    single zu String umwandeln    ***/
	sprintf( xstr, "%d", n );
   /***    String ausgeben    ***/
	if ( fputs(xstr,pf)==EOF )  {
		errmsgio( "fputsi", "EA105" );
		return( ERROR );
	}
	return( 0 );
}
