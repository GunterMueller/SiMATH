/*M
.SH NAME
islistgf2 - is list of Galois-field with characteristic 2 elements ?

.SH SYNOPSIS
.nf
#include<_arith2.h>

single islistgf2(G, L)  
obj G, L;
  
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).  
.PP
islistgf2 returns
.TP 4
1, 
if L can be seen as a list, containing elements of GF(2^n), and
.TP 4
0,
else.
.PP
For L the empty list, islistgf2 returns 1.

.SH SEE ALSO
udpm2tosb

M*/
                        
/*H
	Version 1       13.03.1992	A.Stein
   DATE islistgf2     : 920331
H*/


# include <_arith2.h>

single islistgf2(G,L)
obj G, L;
{
	obj a;

	if ( !islist(L) ) return(0);
	while ( L != _0 ) {
		a = lfirst(L);
		if ( !isgf2el(G,a) ) return(0);
		L = lred(L);
	}
	return(1);
}
