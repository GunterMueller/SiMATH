/*M
.SH NAME
mamstrace - matrix of modular singles, trace

.SH SYNOPSIS
.nf
#include<_matr1.h>

int mamstrace(m, M)
single m;
matrix M;

.SH DESCRIPTION
mamstrace() returns the trace of the matrix M.

.PP
.TP 4
.B M
is a square matrix over Z/mZ.
M*/
/*H
	Version 1       08.07.1994      S. Schmitt
   DATE mamstrace     : 941201
H*/

#include <_matr1.h>

int mamstrace(n,M)
single n;
matrix M;
{
	single i,j;
	list Z1;
	int S;
	bind(M);
	init(S);
                
	S = 0;
	i = 0;
	while ( M != _0 ) {
		i++;
		Z1 = lfirst(M);
		M  = lred(M);
		for(j=1;j<i;j++) Z1=lred(Z1);
		S = mssum(n,S,lfirst(Z1));
	}
	return(S);
}
             	
