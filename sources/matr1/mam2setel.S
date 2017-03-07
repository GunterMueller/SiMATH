/*M
.SH NAME
mam2setel - matrix over Z/2Z, special bit representation, set element

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mam2setel(M, m, n, el)
matrix M;
single m, n;
obj el;

.SH DESCRIPTION
mam2setel() assigns the element el
to the entry at position (m,n) of the matrix M
and then returns M.

.PP
.TP 4
.B M
is a matrix over Z/2Z in special bit representation.
M*/
/*H
	Version 1       20.10.1995	Marc Conrad
   DATE mam2setel     : 951201
H*/

#include <_matr1.h>

int mam2setel( M, m, n, el ) 
	int M, n, m, el; 
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

	if(el) i = i | u; 
	else i = i & (~u); 
	
	lsfirst(M, i); 
	return( 0 ); 
	} 
	
	
	
	
	

