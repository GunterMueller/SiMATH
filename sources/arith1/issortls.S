/*M
.SH NAME
issortls - is sorted list of singles ?

.SH SYNOPSIS
.nf
#include<_arith1.h>

single issortls(A)
obj A;

.SH DESCRIPTION
issortls() returns 1 if A is a (possibly empty)
ascendingly sorted list of singles, and 0 otherwise.
M*/
/*H
	Version 1       29.01.1987      Pascale Serf
	Version 2       02.04.1987      komplette Neufassung. PS
	Version 3       17.08.1987      gehoert ab jetzt zur srclib.kern. MAR.
	Version 4       20.01.1988      komplette Neufassung MAR.
   DATE issortls      : 890501
H*/


# include <_arith1.h>

single issortls( A )
obj A;
{
	single erstes;

	if ( !islists(A) ) return( 0 );
	if ( A != _0 ) {
		erstes = lfirst( A );
		A = lred( A );
	}
	else return( 1 );
	while ( A != _0 )  {
		if ( erstes > lfirst(A) ) return( 0 );
		erstes = lfirst( A );
		A = lred( A );
	}
	return( 1 );
}
