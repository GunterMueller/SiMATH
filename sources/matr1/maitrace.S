/*M
.SH NAME
maitrace - matrix of integers, trace

.SH SYNOPSIS
.nf
#include<_matr1.h>

int maitrace(M)
matrix M;

.SH DESCRIPTION
maitrace() returns the trace of the matrix M.

.PP
.TP 4
.B M
is a square matrix of integers.
M*/





/*H
	Version 1       24.04.1991      J. Schmitt
   DATE maitrace      : 910915
H*/

#include <_matr1.h>

int maitrace(M)
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
		S = isum(S,lfirst(Z1));
	}
	return(S);
}
             	
