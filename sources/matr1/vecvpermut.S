/*M
.SH NAME
vecvpermut - vector of polynomials, variable permutation

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecvpermut(r, V, PP)
single r;
vec V;
list PP;

.SH DESCRIPTION
vecvpermut() returns the vector which results from applying
pvpermut(r,p,PP)
to all entries p of V.

.SH SEE ALSO
pvpermut
M*/
/*H
	Version 1       30.10.1989      C.Hollinger/U.Schneiders
	Version 2	16.05.1994	Einige Variablen geschlossen umbenannt
					wegen Portierung auf Linux. MP
   DATE vecvpermut    : 891101.9311__.941201
H*/

#include<_matr1.h>

vec vecvpermut(r,V,PP)
single r;
vec V;
list PP;

{
	list L;
	pol P;
	init( L, P );
	bind( V, PP );

	L = _0;

	while( V != _0 ) {
		P = lfirst( V );
		V = lred( V );
		P = pvpermut(r,P,PP);
		L = lcomp( P, L );
	}
	L = linv( L );

/* Ausgabe */

	return( L );
}
