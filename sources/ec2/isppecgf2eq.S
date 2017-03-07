/*M
.SH NAME
isppecgf2eq - is projective point of an elliptic curve over Galois-field with characteristic 2 equal ?

.SH SYNOPSIS
.nf
#include<_ec2.h>

single isppecgf2eq(G, PL1, PL2)  
obj G;  
list PL1, PL2;
 
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).                               
.TP 4
.B PL1
is a list of three elements of GF(2^n) in special bit-representation, defining a point, say P1, in projective representation on an elliptic curve E.
.TP 4
.B PL2
is a list of three elements of GF(2^n) in special bit-representation, defining a point, say P2, in projective representation on an elliptic curve E.
.PP  
isppecgf2eq returns 
.IP
 1, if P1 = P2,
 0, if P1 != P2.
                
.SH SEE ALSO
udpm2tosb

M*/

/*H
	Version 1       09.07.1992      Michael Pfeifer
	Version 2	20.10.1994	Dokumentation korrigiert. MP
   DATE isppecgf2eq   : 921130.941201
H*/

#include <_ec2.h>

single          isppecgf2eq(G, P1, P2)
    obj             G;
    list            P1, P2;
{
    single          n;
    list            Q1, Q2;

    bind(G);
    bind(P1, P2);

    init(Q1, Q2);

    Q1 = ecgf2srpp(G, P1);
    Q2 = ecgf2srpp(G, P2);
    n = oequal(Q1, Q2);
    return (n);
}
