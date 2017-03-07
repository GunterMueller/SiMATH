/*M
.SH NAME
scubresc - single cubic residue class

.SH SYNOPSIS
.nf
#include<_arith1.h>

single scubresc(a,p)
int a;
single p;

.SH DESCRIPTION
scubresc() returns the cubic residue class
(a/p)_3 of the integer a and the prime number
p < 2^30.

.SH SEE ALSO
K. Ireland, M. Rosen, "A classical introduction
to modern number theory", Springer-Verlag, New York,
1982, 7.1.2 and 9.3.
M*/
/*H
        Version 1        18.11.1994        Ursula Schneiders
   DATE scuberesc      : 951201
H*/

#include <_arith1.h>

single          scubresc(a, p)
    int             a;
    single          p;
{
    single          h;

    bind(a);

    if (!mshom(p, a))
	return (0);
    if ((p % 3) == 2)
	return (1);
    a = mshom(p, a);
    h = (p - 1) / 3;
    a = msexp(p, a, h);
    if (a == 1)
	return (1);
    else
	return ((-1));
}
