/*M
.SH NAME
misqrtsrch - modular integer square root search

.SH SYNOPSIS
.nf
#include<_arith1.h>

int misqrtsrch(m,a)
int m,a;

.SH DESCRIPTION
misqrtsrch() tries to solve the congruence
.TP 8
.PP
x^2 - a = 0 (mod m),
.PP
and returns x or -1 in case there is no solution.
misqrt() is faster than  misqrtsrch().
If m is prime, the function mpsqrt() should be
used, since it is even faster.

.SH SEE ALSO
misqrt, mpsqrt
M*/
/*H
	Version 1	03.12.1992	Georg Lay (altes misqrt)
   DATE misqrtsrch    : 930115
H*/

#include<_arith1.h>

int misqrtsrch(m, a)
	int             m, a;
{
	int             h1, h2;

	bind(m, a);

	init(h1, h2);

	a = mihom(m, a);
	if (a == 0)
	{
		return (0);
	}
	else
	{
		for (h1 = 1; icomp(h1, m) == -1; h1 = isum(h1, 1))
		{
			h2 = miprod(m, h1, h1);
			h2 = midif(m, a, h2);
			h2 = mihom(m, h2);
			if (h2 == 0)
			{
				return (h1);
			}
		}
	}
	return (-1);
}
