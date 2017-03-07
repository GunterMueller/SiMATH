/*M
.SH NAME
mam2conszero - matrix construction zero, special bit representation

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mam2conszero(m, n)
single m, n;

.SH DESCRIPTION
mam2conszero() returns a mxn-Matrix over Z/2Z in special bit representation
with all entries set to zero.

M*/
/*H
	Version 1       10.10.1995      Marc Conrad
   DATE mam2conszero  : 951201
H*/

#include <_matr1.h>

matrix mam2conszero(m,n)
single m,n;

{
	matrix N; 
	init(N); 
	N = maconszero( m, ((n-1) / 30) + 1); 
	return( lcomp(n, N ));
}
