/*M
.SH NAME
marfrtrace - matrix of rational functions over the rational numbers, trace

.SH SYNOPSIS
.nf
#include<_matr3.h>

obj marfrtrace(r, M)
single r;
matrix M;

.SH DESCRIPTION
marfrtrace() returns the trace of the matrix M.

.PP
.TP 4
.B M
must be a square matrix of rational functions in r variables over the rational numbers.
M*/






/*H
	Version 1       08.07.1991      S. Schmitt
   DATE marfrtrace    : 941201
H*/

#include <_matr3.h>

obj marfrtrace(r,M)
single r;
matrix M;
{
	single i,j;
	list Z1,S;
	bind(M);
	init(S);
                
	S = itopi(r,0);
	S=pitorfr(r,S);
	i = 0;
	while ( M != _0 ) {
		i++;
		Z1 = lfirst(M);
		M  = lred(M);
		for(j=1;j<i;j++) Z1=lred(Z1);
		S = rfrsum(r,S,lfirst(Z1));
	}
	return(S);
}
             	


