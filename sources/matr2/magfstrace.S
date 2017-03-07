/*M
.SH NAME
magfstrace - matrix over Galois-field with single characteristic, trace

.SH SYNOPSIS
.nf
#include<_matr2.h>

obj magfstrace(p, AL, M)
single p;
obj AL;
matrix M;

.SH DESCRIPTION
magfstrace() returns the trace of the matrix M.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M
is a square matrix over GF(p^n).
M*/

/*H
	Version 1       11.07.1994      S. Schmitt
   DATE magfstrace    : 941201
H*/

#include <_matr2.h>

obj magfstrace(p,AL,M)
single p;
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
		S = gfssum(p,AL,S,lfirst(Z1));
	}
	return(S);
}
