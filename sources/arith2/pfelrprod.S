/*M
.SH NAME
pfelrprod - p-adic field element rational number product

.SH SYNOPSIS
.nf
#include<_arith2.h>

pfel pfelrprod(p, a, r)  
single p; 
pfel a; 
rat r;
   
.SH DESCRIPTION
.TP 4
.B p
is a single prime.
.TP 4
.B a
is the approximation of an element (say A) of the p-adic number field Qp (s.itopfel).
.TP 4
.B r
is a rational number.
.PP
pfelrprod returns the approximation of an element of Qp, say B, where     
.IP
B = A * R.

.SH SEE ALSO
itopfel

M*/
                               
/*H
	Version 1       17.08.1990      Christine Hollinger
	Version 2       01.08.1991      PFRPROD -> PFELRPROD.  PS
   DATE pfelrprod     : 901120.9107__.910915
H*/

#include <_arith2.h>

pfel pfelrprod( p, a, R )
single p;
pfel a;
rat R;

{
	bind( a,R );

	if( a && R )
	{       single v;
		int d;
		init( d );

		/*** R = p^d * R' mit p teilt weder Zaehler noch Nenner
				  von R' ***/

		if( ( v = raval( p,R ) ) )
		{       if( v > 0 )
			{       d = iexp( p,v );
				d = itor( d );
				a = pfpprod( p, a, v );
			}
			else
			{       d = ineg( v );
				d = iexp( p,d );
				d = itor( d );
				d = rinv( d );
			}
			R = rquot( R,d );
		}

		/*** => a * R = a * p^d * R' ***/

		d = lfirst( a ) - lsecond( a );
		d++;
		R = rtopfel( p, d, R );
		a = pfprod( p, a, R );
		if( v < 0 )     a = pfpprod( p, a, v );
	}
	else    /*** a * R = 0 ***/
		a = 0;
	return( a );
}
