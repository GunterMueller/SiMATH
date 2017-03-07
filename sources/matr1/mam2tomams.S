/*M
.SH NAME
mam2tomams - matrix over Z/2Z to matrix over modular single

.SH SYNOPSIS
.nf
#include<_matr1.h>

list mam2tomams(M)
list M;

.SH DESCRIPTION
mam2tomams returns the matrix M represented as an nxn matrix over Z/2Z.

.PP
.TP 4
.B M
is a matrix over Z/2Z in special bit representation.


.SH SEE ALSO
mamstom2
M*/
/*H
        Version 1	20.10.1995	Marc Conrad 
   DATE mam2tomams    : 951201
H*/

#include <_matr1.h>

matrix mam2tomams(M)
	matrix M; 
	{ 
	
	list L; 
	matrix H; 
	list Z; 
	single s; 
	single i, u, l; 
	
	bind(M); 
	init( L, H, Z ); 
	
	s = lfirst(M); 
	M = lred(M); 
	H = _0; 
	
	while( M != _0 ){ 
		L = lfirst( M ); 
		M = lred( M ); 
		Z = _0; 
		l = lfirst(L); 
		u = 1 << ((s-1) % 30);  
		for(i=1; i<= s; i++ ) { 
			if( u == 0 ) { 
				u = (1<<29);
				L = lred(L); 
				l = lfirst(L); 
				} 
			Z = lcomp(((u & l) ? 1 : 0), Z); 
			u = (u >> 1); 	
			} 
		H = lcomp(linv(Z),H); 
		} 
	return(linv(H)); 
	} 

	
		
			
				
				

			
			
	
	
	
	
