/*M
.SH NAME
pfneg - p-adic field element negation

.SH SYNOPSIS
.nf
#include<_arith2.h>

pfel pfneg(p,a)       
single p; 
pfel a;
  
.SH DESCRIPTION
.TP 4
.B p
is a single prime.
.TP 4
.B a
is the approximation of an element (say A) of the p-adic number field Qp (s.itopfel).
.PP
pfneg returns the approximation of -1*A with precision d (s. itopfel).

.SH SEE ALSO
itopfel

M*/
                                  
/*H
	Version 1       27.02.1990      Christine Hollinger
   DATE pfneg         : 901120
H*/

#include <_arith2.h>

pfel pfneg( p,a )
single p;
pfel a;

{
	bind( a );

	if( a )
	{       single ai;
		list L;
		init( L );

		/*** -a = p - a_vp(A) + ... + ( p-1-a_i )*p^i + ... ***/

		L = lfirst( a );
		ai = lsecond( a );
		L = list2( ai,L );
		ai = lthird( a );
		ai = p - ai;
		L = lcomp( ai,L );
		a = lred3( a );
		p--;
		while( a != _0 )
		{       ai = lfirst( a );
			a = lred( a );
			ai = p - ai;
			L = lcomp( ai,L );
		}
		a = linv( L );
	}
	return( a );
}
