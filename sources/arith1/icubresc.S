/*M
.SH NAME
icubresc - integer cubic residue class

.SH SYNOPSIS
.nf
#include<_arith1.h>

single icubresc(a,p)
int a,p;

.SH DESCRIPTION
icubresc() returns the cubic residue class (a/p)_3,
.PP
.TP 4
.B a
is an integer
.TP 4
.B p
is a prime number

.SH SEE ALSO
K. Ireland, M. Rosen, A classical introduction
to modern number theory, Springer-Verlag, New York,
1982, 7.1.2 and 9.3.
M*/
/*H
        Version 1        18.11.1994        Ursula Schneiders
   DATE icuberesc      : 951201
H*/

#include <_arith1.h>

single          icubresc(a, p)
    int             a, p;
{
    int             h;

    init(h);
    bind(a);

    if (!mihom(p, a))
	return (0);
    if (mshom(3, p) == 2)
	return (1);
    a = mihom(p, a);
    h = idif(p, 1);
    h = iquot(p, 3);
    a = miexp(p, a, h);
    if (a == 1)
	return (1);
    else
	return ((-1));
}
