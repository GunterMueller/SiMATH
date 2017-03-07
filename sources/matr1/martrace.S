/*M
.SH NAME
martrace - matrix of rational numbers, trace

.SH SYNOPSIS
.nf
#include<_matr1.h>

rat martrace(M)
matrix M;

.SH DESCRIPTION
martrace() returns the trace of the matrix M.

.PP
.TP 4
.B M
is a square matrix of rational numbers.
M*/
/*H
	Version 1       08.07.1994      S. Schmitt
   DATE martrace      : 941201
H*/

#include <_matr1.h>

rat martrace(M)
matrix M;
{
	single i,j;
	list Z1;
	rat S;
	bind(M);
	init(S);
                
	S = itor(0);
	i = 0;
	while ( M != _0 ) {
		i++;
		Z1 = lfirst(M);
		M  = lred(M);
		for(j=1;j<i;j++) Z1=lred(Z1);
		S = rsum(S,lfirst(Z1));
	}
	return(S);
}
             	
