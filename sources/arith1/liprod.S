/*M
.SH NAME
liprod - list of integers product

.SH SYNOPSIS
.nf
#include<_arith1.h>

list liprod(L1,L2)
list L1,L2;

.SH DESCRIPTION
liprod() returns a list containing all products
l1*l2 with l1 in L1 and l2 in L2, i.e. for
L1 = ( a1  a2 ) and L2 = ( b1  b2  b3 ) the
returned list equals (a2*b3  a2*b2  a2*b1  a1*b3  a1*b2  a1*b1).   
M*/
/*H
	Version 1	20.08.1991	Michael Pfeifer
   DATE liprod        : 920331
H*/

#include <_arith1.h>

list            liprod(L1, L2)
    list            L1, L2;
{
    int             i;
    list            L, Lh;

    bind(L1, L2);
    init(i);
    init(L, Lh);

    Lh = L2;
    L = _0;
    while (L1 != _0)
    {
	i = lfirst(L1);
	L2 = Lh;
	while (L2 != _0)
	{
	    L = lcomp(iprod(lfirst(L2), i), L);
	    L2 = lred(L2);
	}
	L1 = lred(L1);
    }
    return (L);
}
