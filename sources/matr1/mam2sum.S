/*M
.SH NAME
mam2sum - matrix over Z/2Z, special bit representation, sum

.SH SYNOPSIS
.nf
#include<_matr1.h>

list mam2sum(M, N)
list M, N;

.SH DESCRIPTION
mam2sum() returns the matrix M+N in special bit representation.

.PP
.TP 4
.B M, N
are matrices over Z/2Z in special bit representation.
M and N must have equal dimensions.
M*/
/*H
        Version 1       27.10.1995     Marc Conrad 
   DATE mam2sum       : 951201
H*/

#include <_matr1.h>

list mam2sum(M, N)
     list M, N;
{
	list X, Y, Z; 
	list L; 
	single a, s; 
	
	init( Z, L); 
	bind( M, N ); 

	L = _0; 
	s = lfirst( M ); 
	M = lred( M ); 
	N = lred( N ); 	

	while( M != _0 ) { 
		X = lfirst( M ); 
		Y = lfirst( N ); 
		M = lred( M ); 
		N = lred( N ); 
		Z = _0; 
		while( X != _0 ) { 
			a = lfirst(X) ^ lfirst( Y ); 
			X = lred(X); 
			Y = lred(Y); 
			Z = lcomp( a, Z ); 
			} 
		L = lcomp( linv(Z), L ); 
		} 
	L = lcomp(s, linv( L ) ); 
	return( L ); 
}
