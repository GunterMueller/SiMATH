/*M
.SH NAME
vecpitransf - vector of polynomials over the integers, transformation

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecpitransf(r1, V, VL1, r2, P2, VL2, VLn, pVL3)
single r1;
vec V;
list VL1;
single r2;
pol P2;
list VL2;
list VLn;
list *pV3;

.SH DESCRIPTION
vecpitransf() returns the vector which results from applying
pitransf
to all entries of V.

.SH SEE ALSO
pitransf
M*/

/*H
	Version 1       30.10.1989     C.Hollinger/U.Schneiders
   DATE vecpitransf   : 891101.9311__
H*/


#include <_matr1.h>

vec vecpitransf(r1,W1,V1,r2,P2,V2,Vn,pV3)
single r1;
vec W1;
list V1;
single r2;
pol P2;
list V2;
list Vn;
list *pV3;

{
	list L, pV;
	pol a, b;
	init( L, pV, a, b );
	bind( W1, V1, P2, V2, Vn );

	L = _0;

	while (W1 != _0)
	{       a = lfirst( W1 );
		b = pitransf(r1,a,V1,r2,P2,V2,Vn,&pV);
		L = lcomp( b,  L );
		W1 = lred( W1 );
	}

	L = linv (L);

/* Ausgabe */

	(*pV3 ) = pV;
	return (L);
}
