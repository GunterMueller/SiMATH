/*M
.SH NAME
mapnftomapr - matrix of polynomials over number field to matrix of polynomials over the rational numbers

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mapnftomapr(r ,M)
single r;
matrix M;

.SH DESCRIPTION
mapnftomapr() returns the matrix M with all entries converted
to polynomials in r+1 variables over the rational numbers.
The coefficients of the polynomials in M are interpreted as
algebraic numbers and converted into polynomials in one variable
over the rational numbers.

M*/






/*H
	Version 1       18.03.1993	S.Schmitt/U.Schneiders
	Version 2	29.10.1993	von 'matr2 nach 'matr3.  PS
   DATE mapnftomapr   : 930531.931130
H*/

#include <_matr3.h>

matrix mapnftomapr( r, M )
single r;
matrix M;
{	matrix NM;
	list Z,NZ;
	pol P;
	init(NM, Z, NZ, P);
	bind(M);

	NM = _0;
	while( M != _0 )
	{	Z = lfirst( M );
		M = lred( M );
		NZ = _0;
		while( Z != _0 )
		{	P = lfirst( Z ); 
			Z = lred( Z );
			P= pnftopr(r,P);
			NZ = lcomp( P, NZ );
		}
		NZ = linv( NZ );
		NM = lcomp( NZ, NM );
	}
	M = linv( NM );
	return(M);
}


