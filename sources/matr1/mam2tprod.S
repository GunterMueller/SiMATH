/*M
.SH NAME
mam2tprod - matrix over Z/2Z, special bit representation, transpose product

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mam2prod(M, N)
list M, N;

.SH DESCRIPTION
Let N(T) be the transpose matrix of the matrix N.
mam2tprod() returns the matrix M*N(T) in special bit representation.

.PP
.TP 4
.B M,N
are matrices of integers in special bit representation.
M and N(T) must have compatible dimensions.
M*/
/*H
        Version 1       27.10.1995      Marc Conrad
   DATE mam2tprod     : 951201
H*/

#include <_matr1.h>

matrix mam2tprod( M, N )
	list M, N;
	{ 
	list Z, L, K; 
	single s, t, z, u, a; 

	bind( M, N); 
	init( L, Z, K ); 
	
	L = _0; 
	M = lred(M); 
	N = lred(N); 
	t = llength(N); 

	while( M != _0 ) { 
		Z = _0; 
		K = N; 
		z = 0; 
		u = 1 << ((t-1)%30); 
		while(K != _0)   { 
			if( u == 0 ) { 
				u = (1<<29); 
				Z = lcomp(z, Z); 
				z = 0; 
				} 
			a = lm2sprod(lfirst(M), lfirst(K)); 
			K = lred( K );
			if( a ) z |= u; 
			u = u >> 1; 
			} 
		M = lred(M); 
		Z = lcomp(z, Z); 
		L = lcomp(linv(Z), L); 
		} 
	L = lcomp(t, linv(L) ); 
	return( L ); 
	} 






			
			
 
	











	
