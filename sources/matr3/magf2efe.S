/*M
.SH NAME
magf2efe - matrix over Galois-field with characteristic 2, embedding in field extension 

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix magf2efe(GmtoGn, M) 
single r;
list GmtoGn;
matrix Mm;

.SH DESCRIPTION
magf2efe() returns the isomorphic embedding of the matrix M
over GF(2^m) in the extension field GF(2^n).
.PP

.TP 4
.B GmtoGn
= (Gn, re) is a list which describes the embedding of a finite
field of characteristic 2 with 2^m elements in an extension field
with 2^n (m|n) elements. GmtoGn can be generated with gf2ies().
G is an irreducible monic polynomial in one variable over Z/2Z
which can be interpreted as the generating polynomial of the
extension field GF(2^n). re is the embedding of a root of the
polynomial which generates the field GF(2^m) in the extension field GF(2^n).

.TP 4
.B M
is a matrix over GF(2^m).

.SH SEE ALSO
gf2ies, vecgf2efe, vecpgf2efe, mapgf2efe
M*/
/*H
	Version  1      14.03.1996      S.Schmitt
   DATE magf2efe      : 960501
H*/
 
#include <_matr3.h>
	
matrix magf2efe( GmtoGn, Mm )
list GmtoGn;
matrix Mm;
{ 	matrix L;
	list V, W;
	obj a;
	init(L, V, W, a);
	bind(GmtoGn, Mm);

	L=_0;
	while(Mm!=_0)
	{	V=lfirst(Mm);
		W=_0;
		while(V!=_0)
		{ 	a=lfirst(V);
			a=gf2efe(GmtoGn,a);
			W=lcomp(a,W);
			V=lred(V);
		}
		W=linv(W);
		L=lcomp(W,L);
		Mm=lred(Mm);
	}
	L=linv(L);	
	return(L);
}


