/*M
.SH NAME
masrand - matrix of singles, randomize

.SH SYNOPSIS
.nf
#include<_matr1.h>

masrand(m, n, bound)
single m, n, bound;

.SH DESCRIPTION
masrand() returns a mxn with all entries set to
single precision numbers randomly chosen from the range [0, bound].
M*/
/*H
	Version 1       26.08.1988      Klaus Petry
   DATE masrand       : 890501.9211__
H*/

#include <_matr2.h>

matrix masrand (m, n, grenze)
single m, n, grenze;

{
	single j;
	matrix M = _0;
	single a;
	list Z;

	bind( M );
	init( Z );

	srand( time( 0L ) );
	while (m--) {
		Z = _0;
		for (j=n; j--; ) {
			do {
				a = rand();
			} while ( a >= BASIS );
			while (a>grenze) a/=10;
			Z = lcomp( a, Z );
			}
		M = lcomp (Z, M);
		}
	return( M );
}
