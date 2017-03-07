/*M
.SH NAME
ecgf2srpp - elliptic curve over Galois-field with characteristic 2, standard representation of projective point

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecgf2srpp(G, PL)  
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
is a list of three elements of GF(2^n) in special bit-representation, defining a point, say P, in projective representation on an elliptic curve, say E.
.PP
ecgf2srpp returns a representation P' = (x', y', z') for the point P, so that
.IP                                                                          
 x' = x/z, y' = y/z, z' = 1, for z != 0, or
 x' = 0,   y' = 1,   z' = 0, for z  = 0.
                             
.SH SEE ALSO
udpm2tosb

M*/
                                   
/*H
	Version 1       08.07.1992      Michael Pfeifer
   DATE ecgf2srpp     : 921130
H*/

#include <_ec2.h>

list            ecgf2srpp(G, P)
    obj             G;
    list            P;
{
    gf2el           x, y, z;

    bind(G);
    bind(P);

    init(x, y, z);

    x = lfirst(P);
    y = lsecond(P);
    z = lthird(P);

    if (z != 0)
    {
	x = gf2quot(G, x, z);
	y = gf2quot(G, y, z);
	z = udpm2togf2el(G, list2(0, 1));
    }
    else
    {
	x = 0;
	y = udpm2togf2el(G, list2(0, 1));
	z = 0;
    }

    return (list3(x, y, z));
}
