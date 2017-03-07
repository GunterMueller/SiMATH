/*M
.SH NAME
isppecgf2pai - is projective point of an elliptic curve over Galois-field with characteristic 2 point at infinity ?

.SH SYNOPSIS
.nf
#include<_ec2.h>

single isppecgf2pai(G, PL)  
obj G; 
list PL;

.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).   
.TP 4
.B PL
is a list of three elements of GF(2^n) in special bit-representation, defining a point, say P, in projective representation on an elliptic curve E. 
.PP
isppecgf2pai returns
.IP
 1, if P = (x y 0),
 0, else.
 
.SH SEE ALSO
udpm2tosb

M*/

/*H
	Version 1       08.07.1992      Michael Pfeifer
   DATE isppecgf2pai  : 921130
H*/

#include <_ec2.h>

single          isppecgf2pai(G, P)
    obj             G;
    list            P;
{
    gf2el           z;

    bind(G);
    bind(P);

    init(z);

    z = lthird(P);

    if (z == 0)
    {
	return (1);
    }
    else
    {
	return (0);
    }
}
