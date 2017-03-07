/*M
.SH NAME
csetpart - characteristic set from partition

.SH SYNOPSIS
.nf
#include<_arith1.h>

obj csetpart(L)
list L;

.SH DESCRIPTION
csetpart() creates an characteristic set from a given partition.

.PP
.TP 4
.B L
is a list ( L(1),...,L(n) ) of non-negative single precision numbers.
.PP
.TP 4
.B S
is a characteristic set, where k is in S if and only if there exists an index set I in {1,...,n} with k = Sum { L(i) | i in I }.
M*/
/*H
	Version 1       13.04.88        R.Boeffgen
   DATE csetpart      : 890501.9011__
H*/


# include <_arith1.h>

obj csetpart( L )
list L;
{
	obj S,T;
	init( S );
	bind( L );
	for ( S=1;  L!=_0;  L=lred(L) )  {
		T = ip2prod( S, lfirst(L) );
		S = csetunion( S,T );
	}
	return( S );
}
