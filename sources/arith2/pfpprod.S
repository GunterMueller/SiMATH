/*M
.SH NAME
pfpprod - p-adic field element prime power product

.SH SYNOPSIS
.nf
#include<_arith2.h>

pfel pfpprod(p, a, i)         
single p, i; 
pfel a;  

.SH DESCRIPTION
.TP 4
.B p
is a single prime.
.TP 4
.B a
is the approximation of an element (say A) of the p-adic number field Qp (s. pfpprod).
.TP 4
.B i
is a single integer number.
.PP
pfpprod returns the approximation of p^i * A.

.SH SEE ALSO
itopfel

M*/
                                         
/*H
	Version 1       17.04.1990      Christine Hollinger
   DATE pfpprod       : 901120
H*/

#include <_arith2.h>

pfel pfpprod( p, a, i )
single p,i;
pfel a;
{
	bind( a );

	/*** p^i * a => v = vp( A ) + i    und   d = d + i ***/

	if( a && i )
	{       single h;

		h = lfirst( a );
		h = h + i;
		leset( a, 1, h );
		h = lsecond( a );
		h = h + i;
		leset( a, 2, h );
	}
	return( a );
}
