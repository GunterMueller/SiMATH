/*M
.SH NAME
maprtransf - matrix of polynomials over the the rational numbers, transformation

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maprtransf(r1, M, VL1, r2, P2, VL2, VLn, pVL3)
single r1;
matrix M;
list VL1;
single r2;
pol P2;
list VL2;
list VLn;
list *pVL3;

.SH DESCRIPTION
maprtransf() returns the matrix which results from applying
prtransf
to all entries of M.

.SH SEE ALSO
prtransf
M*/

/*H
	Version 1       30.10.1989     C.Hollinger/U.Schneiders
   DATE maprtransf    : 891101.9311__
H*/


#include <_matr1.h>

matrix maprtransf(r1,M1,V1,r2,P2,V2,Vn,pV3)
single r1;
matrix M1;
list V1;
single r2;
pol P2;
list V2;
list Vn;
list *pV3;

{
	list L, pV, ZL, ZM;
	pol a, b;
	init( L, pV, ZL, ZM, a, b );
	bind( M1, V1, P2, V2, Vn );

	L = _0;

	while (M1 != _0) {
		ZL = _0;
		ZM = lfirst( M1 );
		while (ZM != _0) {
			a = lfirst (ZM);
			b = prtransf(r1,a,V1,r2,P2,V2,Vn,&pV);
			ZL = lcomp (b, ZL);
			ZM = lred (ZM);
			}
		ZL = linv (ZL);
		L = lcomp (ZL, L);
		M1 = lred( M1 );
		}
	L = linv (L);

/* Ausgabe */

	(*pV3 ) = pV;
	return (L);
}
