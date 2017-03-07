/*M
.SH NAME
pfeliprod - p-adic field element integer product

.SH SYNOPSIS
.nf
#include<_arith2.h>

pfel pfeliprod(p, a, i)  
single p; 
pfel a; 
int i;
  
.SH DESCRIPTION
.TP 4
.B p
is a single prime.
.TP 4
.B a
is the approximation of an element (say A) of the p-adic number field Qp (s.itopfel).
.TP 4
.B i
is an integer number.
.PP
pfeliprod returns the approximation of an element of Qp, say B, where
.IP
B = A * i.

.SH SEE ALSO
itopfel

M*/
                                          
/*H
	Version 1       13.08.1990      Christine Hollinger
	Version 2       01.08.1991      PFIPROD -> PFELIPROD.  PS
   DATE pfeliprod     : 901120.910915
H*/

#include <_arith2.h>

pfel pfeliprod( p, a, i )
single p;
pfel a;
int i;

{
	bind( a,i );

	if( a && i )
	{       int d;
		init( d );

		/*** i = p^d * i'  mit p teilt nicht i' ***/

		if( ( d = iaval( p,i ) ) )
		{       a = pfpprod( p, a, d );
			d = iexp( p,d );
			i = iquot( i,d );
		}

		/*** => a * i = a * p^d * i' ***/

		d = lfirst( a ) - lsecond( a );
		d++;
		i = itopfel( p, d, i );
		a = pfprod( p, a, i );
	}
	else    /*** a*i = 0 ***/
		a = 0;
	return( a );
}
