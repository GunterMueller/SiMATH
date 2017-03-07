/*M
.SH NAME
vecgf2efe - vector over Galois-field with characteristic 2, embedding in field extension 

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecgf2efe(GmtoGn, Vm) 
list GmtoGn;
vec Vm;

.SH DESCRIPTION
vecgf2efe() returns the isomorphic embedding of the vector V
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
.B V
is a vector over GF(2^m).

.SH SEE ALSO
gf2ies, vecgf2efe, magf2efe, mapgf2efe
M*/
/*H
	Version  1      14.03.1996      S.Schmitt
   DATE vecgf2efe     : 960501
H*/
 
#include <_matr3.h>

vec vecgf2efe( GmtoGn,Vm )
list GmtoGn;
vec Vm;
{ 	vec W;
	obj a;
	init(W, a);
	bind(GmtoGn, Vm);

	W=_0;
	while(Vm!=_0)
	{	a=lfirst(Vm);
		a=gf2efe(GmtoGn,a);
		W=lcomp(a,W);
		Vm=lred(Vm);
	}
	W=linv(W);	
	return(W);
}


