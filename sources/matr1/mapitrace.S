/*M
.SH NAME
mapitrace - matrix of polynomials over integers, trace

.SH SYNOPSIS
.nf
#include<_matr1.h>

pol mapitrace(r, M)
single r;
matrix M;

.SH DESCRIPTION
mapitrace() returns the trace of the matrix M.

.PP
.TP 4
.B M
is a square matrix of polynomials over integers.
M*/
/*H
	Version 1       08.07.1991      S. Schmitt
   DATE mapitrace     : 941201
H*/

#include <_matr1.h>

pol mapitrace(r,M)
single r;
matrix M;
{
	single i,j;
	list Z1;
	pol S;
	bind(M);
	init(S);
                
	S = itopi(r,0);
	i = 0;
	while ( M != _0 ) {
		i++;
		Z1 = lfirst(M);
		M  = lred(M);
		for(j=1;j<i;j++) Z1=lred(Z1);
		S = pisum(r,S,lfirst(Z1));
	}
	return(S);
}
             	
