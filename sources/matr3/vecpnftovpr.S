/*M
.SH NAME
vecpnftovpr - vector of polynomials over number field to vector of polynomials over the rational numbers

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecpnftovpr(r, V)
single r;
vec V;

.SH DESCRIPTION
vecpnftovpr() returns the vector V with all entries converted
to polynomials in r+1 variables over the rational numbers.
The coefficients of the polynomials in V are interpreted as
algebraic numbers and converted into polynomials in one variable
over the rational numbers.

M*/









/*H
	Version 1       18.03.1993	S.Schmitt/U.Schneiders
	Version 2	29.10.1993	von 'matr2 nach 'matr3.  PS
   DATE vecpnftovpr   : 930531.931130
H*/

#include <_matr3.h>

vec vecpnftovpr( r, V )
single r;
vec V;
{	vec NV;
	pol P;
	init(NV, P);
	bind(V);
	
	NV = _0;
	while( V != _0 )
	{	P = lfirst( V ); 
		V = lred( V );
		P= pnftopr(r,P);
		NV = lcomp( P, NV );
	}
	V = linv( NV );
	return(V);
}


