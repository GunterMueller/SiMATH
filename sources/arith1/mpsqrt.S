/*M
.SH NAME
mpsqrt - modular primes square root

.SH SYNOPSIS
.nf
#include<_arith1.h>

int mpsqrt(p,a)
int p,a;

.SH DESCRIPTION
mpsqrt() returns a solution of the congruence
.TP 8
.PP
x^2 - a = 0 (mod p).
.PP
p >= 3 is a prime and a is a quadratic residue modulo p.

.SH SEE ALSO
Neal Koblitz, "A Course in Number Theory and Cryptography",
Springer 1987, pp 47, 48.
M*/
/*H
	Version 1	04.04.1991	Michael Pfeifer
	Version 2	17.09.1992	a wird nun mod p reduziert.  MP
   DATE mpsqrt        : 910715.921130
H*/

#include<_arith1.h>

int             mpsqrt(p, a)
    int             p, a;
{
    single          e, h, k;
    int             j, m, n, s, b, r, x, t;

    bind(p, a);
    init(j, m, n, s, b, r, x, t);

    /*
     * Suche kleinsten quadratischen Nichtrest n mod p
     */

    for (n = 1;
	 ijacsym(n, p) == 1;
	 n = isum(n, 1));

    /*
     * Zerlege p - 1 in der Form p - 1 = 2^e * s
     */

    for (s = idif(p, 1), e = 0;
	 mshom(2, s) == 0;
	 s = iquot(s, 2), e++);

    b = miexp(p, n, s);

    a = mihom(p, a);

    r = miexp(p, a, iquot(isum(s, 1), 2));

    j = 0;
    t = 1;
    m = miprod(p, r, miquot(p, r, a));
    for (k = 0; k <= e - 2; k++)
    {
	n = iexp(2, e - k - 2);
	if (mihom(p, miexp(p, miprod(p, t, m), n)) == 1)
	{
	    h = 0;
	}
	else
	{
	    h = 1;
	}
	j = isum(j, iprod(h, iexp(2, k)));
	t = miexp(p, b, iprod(2, j));
    }

    x = mihom(p, miprod(p, miexp(p, b, j), r));

    return (x);
}
