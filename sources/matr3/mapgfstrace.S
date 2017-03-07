/*M
.SH NAME
mapgfstrace - matrix of polynomials over Galois-field with single characteristic, trace

.SH SYNOPSIS
.nf
#include<_matr3.h>

pol mapgfstrace(r, p, AL, M)
single r,p;
obj AL;
matrix M;

.SH DESCRIPTION
mapgfstrace() returns the trace of the matrix M.

.PP
.B p
>2, must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M
must be a square matrix of polynomials in r variables over GF(p^n).
M*/





/*H
	Version 1       11.07.1994      S. Schmitt
   DATE mapgfstrace   : 941201
H*/

#include <_matr3.h>

pol mapgfstrace(r,p,AL,M)
single r,p;
obj AL;
matrix M;
{
	single i,j;
	list Z1;
	obj S;
	bind(AL,M);
	init(S);
                
	S = 0;
	i = 0;
	while ( M != _0 ) {
		i++;
		Z1 = lfirst(M);
		M  = lred(M);
		for(j=1;j<i;j++) Z1=lred(Z1);
		S = pgfssum(r,p,AL,S,lfirst(Z1));
	}
	return(S);
}


