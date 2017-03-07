/*M
.SH NAME
mapmitrace - matrix of polynomials over modular integers, trace

.SH SYNOPSIS
.nf
#include<_matr1.h>

pol mapmitrace(r, m, M)
single r;
int m;
matrix M;

.SH DESCRIPTION
mapmitrace() returns the trace of the matrix M.

.PP
.TP 4
.B M
is a square matrix of polynomials in r variables over Z/mZ.
M*/
/*H
	Version 1       08.07.1994      S. Schmitt
   DATE mapmitrace    : 941201
H*/

#include <_matr1.h>

pol mapmitrace(r,n,M)
single r;
int n;
matrix M;
{
	single i,j;
	list Z1;
	int S;
	bind(n,M);
	init(S);
                
	S = itopi(r,0);
	S=pitopmi(r,S,n);
	i = 0;
	while ( M != _0 ) {
		i++;
		Z1 = lfirst(M);
		M  = lred(M);
		for(j=1;j<i;j++) Z1=lred(Z1);
		S = pmisum(r,n,S,lfirst(Z1));
	}
	return(S);
}
             	
