/*M
.SH NAME
vpmitransf - vector of polynomials over modular integers, transformation

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vpmitransf(r1, m, V, VL1, r2, P2, VL2, VLn, pVL3)
single r1, r2;
int m;
vec V;
pol P2;
list VL1, VL2, VLn, *pVL3;

.SH DESCRIPTION
vpmitransf() returns the vector which results from applying
pmitransf
to all entries of V.

.SH SEE ALSO
pmitransf
M*/

/*H
	Version 1       18.09.1992      U.Schneiders
   DATE vpmitransf    : 921130
H*/

#include <_matr1.h>

vec vpmitransf( r1, m, W1, V1, r2, P2, V2, Vn, pV3 )
single r1;
int m;
vec    W1;
list   V1;
single r2;
pol    P2;
list   V2, Vn, *pV3;

{
	list L, pV;
	pol  a, b;

	bind( m, W1, V1, P2, V2, Vn );
	init( L, pV, a, b );

	L = _0;
	while ( W1 != _0 )
	{
	   a = lfirst( W1 );
	   b = pmitransf( r1, m, a, V1, r2, P2, V2, Vn, &pV );
	   L = lcomp( b,  L );
	   W1 = lred( W1 );
	}
	L = linv( L );

/* Ausgabe */

	( *pV3 ) = pV;
	return( L );
}
