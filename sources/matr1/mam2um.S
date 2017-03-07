/*M
.SH NAME
mam2um - matrix  over Z2/Z, special bit representation, unity matrix

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mam2um(n)
single n;

.SH DESCRIPTION
mam2um() returns the n-dimensional unity matrix over
Z/2Z in special bit representation.

M*/
/*H
	Version 1       20.10.1995      Marc Conrad
   DATE mam2um        : 951201
H*/

#include <_matr1.h>

matrix mam2um(n)
single n;

{
	matrix N; 
	list Z; 
	single u, i, j, z; 

	
	init(N, Z); 
	
	N = _0; 
	for(i=n; i>0; i-- ) { 
		u = 1 << ((n-1)%30); 
		Z = _0; 
		z = 0; 
		for(j=1; j<=n; j++ ) { 
			if( u == 0 ) { 
				Z = lcomp(z, Z); 
				z = 0; 
				u = (1<<29); 
				} 
			if( i == j ) z = u;
			u = u>>1; 
			} 
		Z = lcomp( z, Z); 
		N = lcomp(linv(Z), N); 
		} 

	return( lcomp(n, N ));
}
