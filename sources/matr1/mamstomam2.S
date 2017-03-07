/*M
.SH NAME
mamstomam2 - matrix modular single to matrix in special bit representation

.SH SYNOPSIS
.nf
#include<_matr1.h>

list mamstomam2(M)
matrix M;

.SH DESCRIPTION
mamstomam2() returns the matrix M converted to special bit representation.


.PP
.TP 4
.B M
is a matrix over Z/2Z.
M*/
/*H
        Version 1       27.10.1995      Marc Conrad
   DATE mamstomam2    : 951201
H*/

#include <_matr1.h>


list mamstomam2(H)
	matrix H;
	{ 
	list Z; 
	matrix M,L;  
	single u, l, s; 
	
	bind(H); 
	init(Z,M,L); 

	M = _0; 
	s = llength(lfirst(H)); 
	while(H != _0) { 
		L = _0; 
		Z = lfirst(H); 
		H = lred(H); 
		l = 0; 
		u = 1 << ((s-1)%30);  
		while(Z != _0 ) { 
			if(u == 0 ) { 
				L = lcomp(l, L); 
				u = (1 << 29); 
				l = 0; 
				} 
			if( lfirst(Z) ) { 
				l = l | u; 
				} 
			Z = lred(Z); 
			u = (u>>1); 
			} 
		L = lcomp(l, L); 
		M = lcomp(linv(L), M); 
		} 
	M = linv(M); 
	return( lcomp(s,M) ); 
	} 
		
	
			
			
			








	
