/*M
.SH NAME
mam2prod - matrix over Z/2, special bit representation, product

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mam2prod(M, N)
list M, N;

.SH DESCRIPTION
mam2prod() returns the matrix M*N in special bit representation.

.PP
.TP 4
.B M,N
are matrices of integers in special bit representation.
M and N must have compatible dimensions.
M*/
/*H
        Version 1       27.10.1995      Marc Conrad
   DATE mam2prod      : 951201
H*/

#include <_matr1.h>

matrix mam2prod( M, N )
	list M, N;
	{ 
	bind( M, N); 
	N = mam2transp(N); 
	N = mam2tprod(M, N); 
	return( N ); 
	} 






			
			
 
	











	
