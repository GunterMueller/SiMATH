/*M
.SH NAME
mapmstransf - matrix of polynomials over modular singles, transformation

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapmstransf(r1, m, M, VL1, r2, P2, VL2, VLn, pVL3)
single r1, m;
matrix M;
list VL1;
single r2;
pol P2;
list VL2, VLn, *pVL3;

.SH DESCRIPTION
mapmstransf() returns the matrix which results from applying
pmstransf
to all entries of M.

.SH SEE ALSO
pmstransf
M*/





/*H
	Version 1       27.06.1990	Th. Weis
   DATE mapmstransf   : 910915.9203__
H*/

#include <_matr1.h>

matrix mapmstransf( r1, m, M1, V1, r2, P2, V2, Vn, pV3 )
single r1, m;
matrix M1;
list   V1;
single r2;
pol    P2;
list   V2, Vn, *pV3;

{
	list L, pV, ZL, ZM;
	pol  a, b;

	bind( M1, V1, P2, V2, Vn );
	init( L, pV, ZL, ZM, a, b );

	L = _0;
	while ( M1 != _0 )
	{
	   ZL = _0;
	   ZM = lfirst( M1 );
	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      b = pmstransf( r1, m, a, V1, r2, P2, V2, Vn, &pV );
	      ZL = lcomp( b, ZL );
	      ZM = lred( ZM );
	   }
	   ZL = linv( ZL );
	   L = lcomp( ZL, L );
	   M1 = lred( M1 );
	}
	L = linv( L );

/* Ausgabe */

	( *pV3 ) = pV;
	return( L );
}
