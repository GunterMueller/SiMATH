/*M
.SH NAME
vpmstransf - vector of polynomials over modular singles, transformation

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vpmstransf(r1, m, V, VL1, r2, P2, VL2, VLn, pVL3)
single r1, m;
vec V;
list VL1;
single r2;
pol P2;
list VL2, VLn, *pVL3;

.SH DESCRIPTION
vpmstransf() returns the vector which results from applying
prtransf
to all entries of V.

.SH SEE ALSO
prtransf
M*/

/*H
	Version 1       27.06.1990      Th. Weis
   DATE vpmstransf    : 910915
H*/

#include <_matr1.h>

vec vpmstransf( r1, m, W1, V1, r2, P2, V2, Vn, pV3 )
single r1, m;
vec    W1;
list   V1;
single r2;
pol    P2;
list   V2, Vn, *pV3;

{
	list L, pV;
	pol  a, b;

	bind( W1, V1, P2, V2, Vn );
	init( L, pV, a, b );

	L = _0;
	while ( W1 != _0 )
	{
	   a = lfirst( W1 );
	   b = pmstransf( r1, m, a, V1, r2, P2, V2, Vn, &pV );
	   L = lcomp( b,  L );
	   W1 = lred( W1 );
	}
	L = linv( L );

/* Ausgabe */

	( *pV3 ) = pV;
	return( L );
}
