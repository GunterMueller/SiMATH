/*M
.SH NAME
marfrtransf - matrix of rational functions over the the rational numbers, transformation

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix marfrtransf(r1, M1, V1, r2, R2, V2, Vn, pV3)
single r1;
matrix M1;
list V1;
single r2;
rfunc R2;
list V2,Vn,*pV3;

.SH DESCRIPTION
marfrtransf() returns the matrix
which arises by replacing the variable Vn by
the rational function R2 in the matrix M1.
If a denominator becomes zero due to this
transformation, marfrtransf() will return -BASIS-1.
The resulting variable list will be stored in *pV3.

.PP
.TP 4
.B M1
is a matrix of rational functions in r1 variables over the rational numbers.
.TP 4
.B V1
is the variable list corresponding to M1.
.TP 4
.B R2
is a rational function in r2 variables over the rational numbers.
.TP 4
.B V2
is the variable list corresponding to P2.
.TP 4
.B Vn
is a list containing one of the elements of V1.
.TP
.B *pV3
is the variable list where the union of the two lists
V1 and V2 will be stored in alphabetical order.
M*/







/*H
	Version 1       31.10.1989      C.Hollinger/U.Schneiders
   DATE marfrtransf   : 910715.9109__
H*/

#include <_matr3.h>

matrix marfrtransf(r1,M1,V1,r2,R2,V2,Vn,pV3)
single r1;
matrix M1;
list V1;
single r2;
rfunc R2;
list V2, Vn, *pV3;
{
	list L, pV, ZL, ZM;
	pol a, b;
	init( L, pV, ZL, ZM, a, b );
	bind( M1, V1, R2, V2, Vn );

	L = _0;

	while (M1 != _0) {
		ZL = _0;
		ZM = lfirst( M1 );
		while (ZM != _0) {
			a = lfirst (ZM);
			b = rfrtransf(r1,a,V1,r2,R2,V2,Vn,&pV);
			if( b == ( -BASIS - 1 ) )  return( -BASIS - 1 );
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


