/*M
.SH NAME
rneg - rational number negation

.SH SYNOPSIS
.nf
#include<_arith1.h>

rat rneg(R)
rat R;

.SH DESCRIPTION
rneg() returns -R.
M*/
/*H
	Version 1       28.7.1986               R.Boeffgen
	Version 2       21.01.1987      Macro -> Funktion M.A. R.
   DATE rneg          : 890501
H*/


# include <_arith1.h>

rat rneg( R )
rat R;
{
	rat erg;
	if ( !R ) return( 0 );
	bind( R );
	init( erg );
	erg = list1( lsecond(R) );
	erg = lcomp( ineg(lfirst(R)) , erg );
	return( erg );
}
