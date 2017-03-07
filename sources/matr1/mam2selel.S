/*M
.SH NAME
mam2selel - matrix in special bit representation, select element

.SH SYNOPSIS
.nf
#include<_matr1.h>

single mam2setel(M, m, n)
matrix M;
single m, n;

.SH DESCRIPTION
mam2selel() returns the element at position (m,n) of the matrix M.
M*/
/*H
	Version 1       20.10.1995	Marc Conrad
   DATE mam2selel     : 951201
H*/

#include <_matr1.h>

single mam2selel( M, m, n ) 
	int M, n, m; 
	{ 

	int i, u, s; 
		
	s = lfirst(M);
	M = lred( M ); 

	for(i=1; i<m; i++ ) M = lred(M); 
	M = lfirst(M); 
	u = (1 << ((s-1)%30));
	
	for(i=1; i< n; i++) { 
		u = u >> 1; 
		if( u == 0 ) { 
			u = (1<<29); 
			M = lred( M ); 
			} 	
		} 
	i = lfirst(M); 
	return( (i & u) != 0); 

	} 
	
	
	
	
	

