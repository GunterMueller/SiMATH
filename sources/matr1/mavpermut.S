/*M
.SH NAME
mavpermut - matrix of polynomials, variable permutation

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mavpermut(r, M, PP)
single r;
matrix M;
list PP;

.SH DESCRIPTION
mavpermut() returns the matrix which results from applying
pvpermut(r, p, PP)
to all entries p of M.

.SH SEE ALSO
pvpermut
M*/
/*H
	Version 1       30.10.1989      C.Hollinger/U.Schneiders
	Version 2	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE mavpermut     : 891101.9311__.941201
H*/

#include<_matr1.h>

matrix mavpermut(r,M,PP)
single r;
matrix M;
list PP;

{
	list L, ZL, ZM;
	pol P;
	init( L, ZL, ZM, P );
	bind( M, PP );

	L = _0;

	while( M != _0 ) {
		ZL = _0;
		ZM = lfirst( M );
		M = lred( M );
		while( ZM != _0 ) {
			P = lfirst( ZM );
			ZM = lred( ZM );
			P = pvpermut(r,P,PP);
			ZL = lcomp( P, ZL );
			}
		ZL = linv( ZL );
		L = lcomp( ZL, L );
		}
	L = linv( L );

/* Ausgabe */

	return( L );
}
