/*M
.SH NAME
mam2transp - matrix in special bit representation, transpose

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mam2transp(M)
list M;

.SH DESCRIPTION
mam2transp() returns the transpose of the matrix M without changing M.

.PP
.TP 4
.B M
must be a matrix Z/2Z in special bit representation.
M*/

/*H
        Version 1       27.10.1995     Marc Conrad 
   DATE mam2transp    : 951201
H*/

#include <_matr1.h>

matrix mam2transp(M)
	matrix M; 
	{ 
	
	matrix L; 
	list Z, X, K; 
	single s, t; 
	single i, u,v, x, a, ff; 
	
	bind(M); 
	init( L, X, Z, K ); 
	
	s = lfirst(M); 
	M = lred(M); 
	L = _0; 
	for(i=1; i<=s; i++) L = lcomp( list1(0), L ); 

	t = llength(M); 
	v = (1 << ((t-1)%30)); 
	
	while( M != _0 ){ 
		X = lfirst( M ); 
		M = lred( M ); 
		u = (1 << ((s-1)%30)); 
		K = L; 
		if( v == 0) { 
			v = (1<<29); 
			ff = 1; 
			} 
		else ff = 0; 

		for(i=1; i<= s; i++ ) { 
			if( u == 0 ) { 
				u = (1<<29);
				X = lred(X); 
				} 
			if(ff) { 
				Z = lcomp( 0, lfirst(K)); 
				lsfirst(K, Z); 
				} 
			else Z = lfirst( K ); 
				 
			if( lfirst(X) & u )  { 
				lsfirst(Z, lfirst(Z) | v); 
				} 
			if( M == _0 ) { 
				Z = linv(Z); 
				lsfirst( K, Z ); 
				} 
			K = lred( K ); 

			u = (u>>1); 	
			} 
		v = (v>>1); 
		} 
	return( lcomp( t, L ) ); 

	} 

	
		
			
				
				

			
			
	
	
	
	
